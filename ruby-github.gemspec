Gem::Specification.new do |s|
  s.name = "ruby-github"
  s.version = "0.0.5"
  s.date = "2008-04-26"
  s.summary = "Simple Ruby library to access the GitHub API."
  s.email = "michael@intridea.com"
  s.homepage = "http://github.com/mbleigh/ruby-github"
  s.description = "Ruby-GitHub is a small library that provides simple access to GitHub's evolving API."
  s.has_rdoc = true
  s.authors = ["Michael Bleigh"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "ruby-github.gemspec", "lib/ruby-github.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("mbleigh-mash", [">= 0.0.5"])
end