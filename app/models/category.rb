class Category < ActiveRecord::Base
  include OrderedByName

  validates_presence_of :name
  has_many :server_categories
  has_many :servers, :through => :server_categories

  def self.for_feed
    where('categories.name' => ["Deatmatch", "MGE"])
  end
end
