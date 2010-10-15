require 'rubygems'
require 'json'
require 'open-uri'
require 'mash'

module GitHub
  class API
    BASE_URL = "http://github.com/api/v2/json"
  
    # Fetches information about the specified user name.
    def self.user(user)
      url = BASE_URL + "/user/show/#{user}"
      GitHub::User.new(JSON.parse(open(url).read)["user"])
    end
  
    # Fetches the commits for a given repository.
    def self.commits(user,repository,branch="master")
      url = BASE_URL + "/#{user}/#{repository}/commits/#{branch}"
      JSON.parse(open(url).read)["commits"].collect{ |c| 
        GitHub::Commit.new(c.merge(:user => user, :repository => repository))
      }
    end
    
    def self.repository(user,repository)
      GitHub::API.user(user).repositories.select{|r| r.name == repository}.first
    end
  
    # Fetches a single commit for a repository.
    def self.commit(user,repository,commit)
      url = BASE_URL + "/#{user}/#{repository}/commit/#{commit}"
      GitHub::Commit.new(JSON.parse(open(url).read).merge(:user => user, :repository => repository))
    end
    
    def self.search(term)
      email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      if term.match(email_regex)
        url = BASE_URL + "/user/email/#{term}"
        GitHub::User.new(JSON.parse(open(url).read)["user"])
      else
        url = BASE_URL + "/user/search/#{term}"
        GitHub::User.new(JSON.parse(open(url).read)["users"].first)
      end
    end
    
    def self.tree(user, repository, tree_sha)
      url = BASE_URL + "/tree/show/#{user}/#{repository}/#{tree_sha}"
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
