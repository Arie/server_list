class ServerCategory < ActiveRecord::Base
  belongs_to :server
  belongs_to :category
end
