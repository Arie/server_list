class Location < ActiveRecord::Base
  include OrderedByName

  attr_accessible :name, :flag
  validates_presence_of :name, :flag

end
