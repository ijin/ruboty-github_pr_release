module Ruboty
  module GithubPrRelease
    module Actions
      class Release < Ruboty::Github::Actions::CreatePullRequest

        private

        def body
          diff = client.compare(repository, base, from_branch)
          merged_pr = diff.commits.select{|c| c.commit.message =~ /Merge pull request #/}
          Ruboty.logger.debug("Found merged pull requests: #{merged_pr.size}")
          body = "Releasing these pull requests:\n\n"
          merged_pr.collect do |pr|
            if match = /Merge pull request (?<merge_num>#\d+) from.*\n\n(?<merge_title>.*)/.match(pr.commit.message)
              num, title = match.captures
              body +=  "- [ ] #{num} #{title} @#{pr.author.login}\n"
            end
          end
          Ruboty.logger.debug("body: \n#{body}")
          # TODO: put slack login id if exists
          body
        end

        def create
          message.reply("Created #{pull_request.html_url}")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue Octokit::UnprocessableEntity
          message.reply("No commits between #{from_branch} and #{base}")
        rescue PrExistsError
          message.reply("This pull request is already open")
        rescue => exception
          message.reply("Failed by #{exception.class} #{exception}")
        rescue PrExistsError => e
          message.reply(e)
        end

        def pull_request
          Ruboty.logger.debug("repo: #{repository}")
          Ruboty.logger.debug("base: #{base}")
          Ruboty.logger.debug("from_branch (head): #{from_branch}")
          Ruboty.logger.debug("title: #{title}")
          current_pr = current_pull_request
          raise PrExistsError, "Pull Request already exists" unless current_pr.empty?
          client.create_pull_request(repository, base, from_branch, title, body)
        end

        def title
          # TODO: title with date (jst active support)
          message[:title] || "Release to #{base}"
        end

        def current_pull_request
          client.pull_requests(repository, head: from_branch, base: base)
        end
      end

      class PrExistsError < StandardError
      end
    end
  end
end
