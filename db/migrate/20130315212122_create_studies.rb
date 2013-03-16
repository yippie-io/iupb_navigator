class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :name
      t.string :source_id
      t.integer :faculty_id
      
      t.timestamps
    end
  end
end
