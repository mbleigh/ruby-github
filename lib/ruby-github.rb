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
      url = BASE_URL + "/commits/list/#{user}/#{repository}/#{branch}"
      JSON.parse(open(url).read)["commits"].collect do |c| 
        GitHub::Commit.new(c.merge(:user => user, 
                                   :repository => repository))
      end
    end
    
    def self.repository(user,repository)
      url = BASE_URL + "/repos/show/#{user}/#{repository}"
      GitHub::Repository.new(JSON.parse(open(url).read)["repository"])
    end
    
    # Fetches a single commit for a repository.
    def self.commit(user,repository,commit_sha)
      url = BASE_URL + "/commits/show/#{user}/#{repository}/#{commit_sha}"
      GitHub::Commit.new(JSON.parse(open(url).read).merge(:user => user, 
                                                          :repository => repository))
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
      JSON.parse(open(url).read)["tree"].collect do |t|
        t.merge(:user             => user, 
                :repository       => repository, 
                :immediate_parent => tree_sha)
        GitHub::Tree.new(t)
      end
    end
    
    def self.blobs(user, repository, tree_sha)
      url = BASE_URL + "/blob/full/#{user}/#{repository}/#{tree_sha}"
      JSON.parse(open(url).read)["blobs"].collect do |b|
        b.merge(:user             => user, 
                :repository       => repository)
        GitHub::Blob.new(b)
      end
    end
    
    def self.blob(user, repository, tree_sha, path, meta=false)
      url = BASE_URL + "/blob/show/#{user}/#{repository}/#{tree_sha}/#{path}"
      url = url + "?meta=1" if meta
      GitHub::Blob.new(JSON.parse(open(url).read)["blob"])
    end
  end
  
  class Repository < Mash
    def commits
      ::GitHub::API.commits(user,name)
    end
  end
  
  class Tree < Mash
    def leaf?
      self.type.eql?("blob")
    end
  end
  
  class Blob < Mash    
  end
  
  class User < Mash
    def initialize(hash = nil)
      @user = hash["login"] if hash
      super
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
