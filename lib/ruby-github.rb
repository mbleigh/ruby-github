require 'rubygems'
require 'json'
require 'open-uri'

class GitHub
  def self.grab(user, repo=nil, branch=nil, commit=nil) #:nodoc:
    url = "http://github.com/api/v1/json/#{user}"
    
    if repo
      url += "/#{repo}"
      url += commit ? "/commit/#{commit}" : "/commits/#{branch}"
    end
    
    GitHub::Hash.new(JSON.parse(open(url).read),user,repo)
  end
  
  # Fetches information about the specified user name.
  def self.user(user)
    self.grab(user).user
  end
  
  # Fetches the commits for a given repository.
  def self.commits(user,repository,branch="master")
    self.grab(user,repository,branch).commits
  end
  
  # Fetches a single commit for a repository.
  def self.commit(user,repository,commit)
    self.grab(user,repository,nil,commit).commit
  end
end

class GitHub::Hash < Hash #:nodoc: all
  def initialize(hash = nil, user = nil, repo = nil, obj = nil)
    super(obj)
    
    @user = user
    @repo = repo
    
    if hash && hash.is_a?(Hash)
      hash.each do |k,v| 
        v = ::GitHub::Hash.new(v,user,repo,obj) if v.is_a?(Hash) && !v.is_a?(::GitHub::Hash)
        if v.is_a?(Array)
          v = v.collect{|potential_hash|
            potential_hash = ::GitHub::Hash.new(potential_hash,user,repo,obj) if potential_hash.is_a?(Hash) && !potential_hash.is_a?(::GitHub::Hash)
            potential_hash
          }
        end
        self[k] = v
      end
    end
  end
  
  def id
    self["id"] ? self["id"] : super
  end
  
  def [](key)
    key = key.to_s
    super
  end
  
  def []=(key,value)
    key = key.to_s
    super
  end
  
  def method_missing(method_name, *args)
    if (match = method_name.to_s.match(/(.*)=$/)) && args.size == 1
      self[match[1]] = args.first
    elsif keys.include?(method_name.to_s)
      self[method_name]
    elsif method_name.to_s == "commits" && self["name"] && self["url"]
      GitHub.commits(@user, name)
    elsif method_name.to_s == "detailed" && self["id"] && self["message"]
      GitHub.commit(@user,@repo,self["id"])
    else
      super
    end
  end
end