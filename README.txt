== Ruby-GitHub

= DESCRIPTION:

Ruby-GitHub is a simple wrapper library for the evolving GitHub API.

= INSTALLATION:

Gem:

The gem is hosted on GitHub so you will need to execute the first line if you have not installed any gems from GitHub before.

  sudo gem install mbleigh-ruby-github --source=http://gems.github.com

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
  
  repository = GitHub::API.repository('mbleigh','ruby-github')
  # => <GitHub::Repository name="ruby-github">

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

* GitHub Project: http://github.com/mbleigh/ruby-github
* Lighthouse: http://mbleigh.lighthouseapp.com/projects/10115-ruby-github

= KNOWN ISSUES/FUTURE DEVELOPMENT:

Right now this library isn't spec'ed out, that's the top priority moving forward. It
will likely also have to evolve substantially as the GitHub API becomes more mature.
If you have any questions or requests, don't hesitate to put them on the Lighthouse!

Copyright (c) 2008 Michael Bleigh (http://mbleigh.com/) 
and Intridea Inc. (http://intridea.com/), released under the MIT license

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.