class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :name
      t.text :description
      t.string :link
      t.string :mail
      t.string :custom_role_name
      t.integer :role_id

      t.timestamps
    end
  end
end
