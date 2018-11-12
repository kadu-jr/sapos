class RemoteDb < ActiveRecord::Base
  establish_connection REMOTE_DB
  self.abstract_class = true
end