module Ruboty
  module GithubPrRelease
    module Actions
      class Release < Ruboty::Actions::Base
        def call
          message.reply(release)
        rescue => e
          message.reply(e.message)
        end

        private
        def release
          # TODO: main logic
        end
      end
    end
  end
end
