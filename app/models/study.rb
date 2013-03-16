class Study < ActiveRecord::Base
  attr_accessible :name, :source_id, :faculty_id
  belongs_to :faculty
  has_many :infos
end
