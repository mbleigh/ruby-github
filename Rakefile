require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "ruby-github"
  s.version = "0.0.1"
  s.author = "Michael Bleigh"
  s.email = "michael@intridea.com"
  s.homepage = "http://www.mbleigh.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple Ruby library for accessing information through the GitHub API."
  s.files = FileList["{spec,lib}/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = %w(README LICENSE)
  s.add_dependency "json"
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 
