class Faculty < ActiveRecord::Base
  attr_accessible :name, :source_id
  has_many :studies
end
