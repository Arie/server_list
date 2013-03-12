class ServerProperty < ActiveRecord::Base
  belongs_to :server
  belongs_to :property
end
