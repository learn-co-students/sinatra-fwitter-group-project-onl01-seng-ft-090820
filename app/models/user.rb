require 'pry'
class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    if @slug
      @slug
    else
      @slug = self.username.split.join("-")
    end
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end

end
