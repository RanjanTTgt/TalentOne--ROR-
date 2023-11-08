class Node < ApplicationRecord
  has_many :nodes, :foreign_key => 'parent_id', :dependent => :destroy
  validates_presence_of :name
  attr_accessor :count, :path_name
end
