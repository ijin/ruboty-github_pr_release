require "ruboty/github_pr_release/actions/release"

module Ruboty
  module Handlers
    class GithubPrRelease < Base
      on(
        /release from (?<from>.+) to (?<to>.+:\S+)( as "(?<title>.+)")?\z/,
        name: 'release',
        description: "Creates a 'release pull request'"
      )

      on(
        /update release from (?<from>.+) to (?<to>.+:\S+)( as "(?<title>.+)")?\z/,
        name: 'update_release',
        description: "Updates a 'release pull request'"
      )

      on(
        /deploy release from (?<from>.+) to (?<to>.+)\z/,
        name: 'deploy_release',
        description: "Merges a 'release pull request' for deployment"
      )

      def release(message)
        Ruboty::GithubPrRelease::Actions::Release.new(message).call
      end

      def update_release(message)
        Ruboty::GithubPrRelease::Actions::UpdateRelease.new(message).call
      end

      def deploy_release(message)
        Ruboty::GithubPrRelease::Actions::DeployRelease.new(message).call
      end
    end
  end
end
