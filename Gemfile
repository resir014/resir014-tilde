source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
gem 'scss_lint'

group :jekyll_plugins do
  gem 'jekyll-paginate-v2'
end

gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw] if Gem.win_platform?
