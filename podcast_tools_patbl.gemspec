# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "podcast_tools/version"

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 2.6.0"
  s.name = "earadio"
  s.summary = "Tools for my podcast"
  s.version = PodcastTools::VERSION
  s.date = "2019-02-03"
  s.authors = ["Patrick Brinich-Langlois"]
  s.email = "pbrinichlanglois@gmail.com"
  s.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.homepage = "https://github.com/patbl/podcast_tools"
  s.license = "MIT"
  s.require_paths = ["lib"]

  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"

  s.add_runtime_dependency "google-api-client"
end
