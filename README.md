# Ruboty::GithubPrRelease

Manages the creation and merging of  `release pull requests` via Ruboty.

## Installation

Add this line to your application's Gemfile:

```ruby
# Gemfile
gem 'ruboty-github_pr_release'
```

## Usage

- @ruboty release from "from" to "to"[as "title"] - Creates a `release pull request`
- @ruboty update release from "from" to "to"[as "title"] - Updates a `release pull request`
- @ruboty deploy release from "from" to "to" - Merges a `release pull request` for deployment

## Notes

Be careful not to `revert` a merge. Otherwise, further pull requests cannot be made.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruboty-github_pr_release.

