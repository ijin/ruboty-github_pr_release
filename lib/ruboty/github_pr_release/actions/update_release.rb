module Ruboty
  module GithubPrRelease
    module Actions
      class UpdateRelease < Release

        private

        def create
          message.reply("Updated #{pull_request.html_url}")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue => exception
          message.reply("Failed by #{exception.class} #{exception}")
        rescue NoPrExistsError => e
          message.reply(e)
        end

        def pull_request
          Ruboty.logger.debug("repo: #{repository}")
          Ruboty.logger.debug("base: #{base}")
          Ruboty.logger.debug("from_branch (head): #{from_branch}")
          Ruboty.logger.debug("title: #{title}")
          current_pr = current_pull_request
          raise NoPrExistsError, "Pull Request does NOT exist" if current_pr.empty? 
          b = body
          message_diff('title', current_pr.first.title, title)
          message_diff('body', current_pr.first.body, b)
          client.update_pull_request(repository, current_pr.first.number, title: title, body: b)
        end

        def message_diff(what, old, new)
          diff = Diffy::Diff.new(old, new)
          if
            Ruboty.logger.debug("updating #{what}:\n#{diff.to_s(:color)}\n")
            message.reply("updating #{what}:\n#{diff.to_s.gsub(/\\ No newline at end of file\n/, '')}\n") unless diff.to_s.empty?
          end
        end

      end

      class NoPrExistsError < StandardError
      end
    end
  end
end
