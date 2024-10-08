source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails-controller-testing'

spree_opts = '4.10.1'
gem 'spree', spree_opts
gem 'spree_emails', spree_opts
gem 'spree_backend', '4.8.4'

gemspec
