class Info < ActiveRecord::Base
  attr_accessible :description, :link, :mail, :name, :role_id, :custom_role_name, :study_id
  belongs_to :role
  belongs_to :study
end
