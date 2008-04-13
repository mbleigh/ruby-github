require 'rubygems'
require 'json'
require 'open-uri'
require 'mash'

module GitHub
  VERSION = "0.0.2"
  class API
    BASE_URL = "http://github.com/api/v1/json"  
  
    # Fetches information about the specified user name.
    def self.user(user)
      url = BASE_URL + "/#{user}"
      GitHub::User.new(JSON.parse(open(url).read)["user"])
    end
  
    # Fetches the commits for a given repository.
    def self.commits(user,repository,branch="master")
      url = BASE_URL + "/#{user}/#{repository}/commits/#{branch}"
      JSON.parse(open(url).read)["commits"].collect{ |c| 
        GitHub::Commit.new(c.merge(:user => user, :repository => repository))
      }
    end
  
    # Fetches a single commit for a repository.
    def self.commit(user,repository,commit)
      url = BASE_URL + "/#{user}/#{repository}/commit/#{commit}"
      GitHub::Commit.new(JSON.parse(open(url).read).merge(:user => user, :repository => repository))
    end
  end
  
  class Repository < Mash
    def commits
      ::GitHub::API.commits(user,name)
    end
  end
  
  class User < Mash
    def initialize(hash = nil)
      @user = hash["login"] if hash
      super
    end
    
    def repositories=(repo_array)
      puts self.inspect
      self["repositories"] = repo_array.collect{|r| ::GitHub::Repository.new(r.merge(:user => login || @user))}
    end
  end
  
  class Commit < Mash
    # if a method only available to a detailed commit is called,
    # automatically fetch it from the API
    def detailed
      ::GitHub::API.commit(user,repository,id)
    end
  end
end