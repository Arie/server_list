class Property < ActiveRecord::Base
  include OrderedByName
  validates_presence_of :name
end
