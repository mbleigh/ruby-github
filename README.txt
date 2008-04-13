== Ruby-GitHub

= DESCRIPTION:

Ruby-GitHub is a simple wrapper library for the evolving GitHub API.

= INSTALLATION:

RubyGem:

  sudo gem install ruby-github

GitHub Clone:

  git clone git://github.com/mbleigh/ruby-github.git

= DEPENDENCIES:

* Requires the 'json' gem
* Requires the 'mash' gem

= SYNOPSIS:
  
  require 'ruby-github'
  
  user = GitHub.user('mbleigh')
  user.name # => "Michael Bleigh"
  user.repositories # => array of repositories
  user.repositories.last.name # => "ruby-github"
  user.repositories.last.url # => "http://github.com/mbleigh/ruby-github"
  user.repositories.last.commits # => array of commits (see below)

  commits = GitHub.commits('mbleigh','ruby-github')
  commits.first.message # => "Moved github.rb to ruby-github.rb..."
  commits.first.id # => "1d8c21062e11bb1ecd51ab840aa13d906993f3f7"

  # these two lines are equivalent
  commit = commits.first.detailed
  commit = GitHub.commit('mbleigh', 'ruby-github', '1d8c21062e11bb1ecd51ab840aa13d906993f3f7')

  commit.message # => "Moved github.rb to ruby-github.rb..."
  commit.added.collect{|c| c.filename} # => ["init.rb", "lib/ruby-github.rb"]

Note that the information is less complete in the 'commits' pull
than in the pull for an individual commit. calling 'detailed' on
a commit retreived from a 'commits' call will make a 'commit' call
for that specific commit.
  
= RESOURCES:

* GitHub Project: http://github.com/mbleigh/ruby-github
* E-Mail: michael@intridea.com