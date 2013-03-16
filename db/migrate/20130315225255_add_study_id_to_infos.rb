class AddStudyIdToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :study_id, :integer
  end
end
