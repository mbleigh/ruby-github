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
  
  user = GitHub::API.user('mbleigh')
  user.name # => "Michael Bleigh"
  user.repositories # => array of repositories
  user.repositories.last.name # => "ruby-github"
  user.repositories.last.url # => "http://GitHub::API.com/mbleigh/ruby-github"
  user.repositories.last.commits # => requests array of commits (see below)

  commits = GitHub::API.commits('mbleigh','ruby-github')
  commits.first.message # => "Moved GitHub::API.rb to ruby-GitHub::API.rb..."
  commits.first.id # => "1d8c21062e11bb1ecd51ab840aa13d906993f3f7"

  # these two lines are equivalent
  commit = commits.first.detailed
  commit = GitHub::API.commit('mbleigh', 'ruby-github', '1d8c21062e11bb1ecd51ab840aa13d906993f3f7')

  commit.message # => "Moved GitHub::API.rb to ruby-GitHub::API.rb..."
  commit.added.collect{|c| c.filename} # => ["init.rb", "lib/ruby-GitHub::API.rb"]

Note that the information is less complete in the 'commits' pull
than in the pull for an individual commit. calling 'detailed' on
a commit retreived from a 'commits' call will make a 'commit' call
for that specific commit.

Here's a one-liner that uses all parts of the Ruby-GitHub library:

latest_commit_filenames = GitHub::API.user('mbleigh').repositories.first.commits.first.detailed.modified.collect(&:filename)
  
= RESOURCES:

* GitHub Project: http://GitHub::API.com/mbleigh/ruby-github
* E-Mail: michael@intridea.com

= KNOWN ISSUES/FUTURE DEVELOPMENT:

Right now this library isn't spec'ed out, that's the top priority moving forward. It
will likely also have to evolve substantially as the GitHub API becomes more mature.
If you have any questions or requests, don't hesitate to e-mail me!