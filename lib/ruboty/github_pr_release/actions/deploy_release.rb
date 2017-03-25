module Ruboty
  module GithubPrRelease
    module Actions
      class DeployRelease < UpdateRelease

        private

        def create
          message.reply("Merged #{pull_request.html_url} for deployment")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue => exception
          message.reply("Failed by #{exception.class} #{exception}")
        rescue NoPrExistsError => e
          message.reply(e) #TODO e=> e.message?
        end

        def pull_request
          current_pr = current_pull_request
          raise NoPrExistsError if current_pr.empty?
          issue = current_pr.first
          client.merge_pull_request(repository, issue.number)
          issue
        end
      end
    end
  end
end
