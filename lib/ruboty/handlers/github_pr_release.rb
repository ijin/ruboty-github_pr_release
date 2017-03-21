require "ruboty/github_pr_release/actions/release"

module Ruboty
  module Handlers
    # Creates a 'releaes pull request'
    class GithubPrRelease < Base
      on /(?<from>.+) to (?<to>.+)z/, name: 'release', description: 'Creates a 'release pull request''


      def release(message)
        Ruboty::GithubPrRelease::Actions::Release.new(message).call
      end

    end
  end
end
