class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :name  						, null: false
      t.string :gender						, null: false
      t.string :email 						, null: false
      t.string :contact						, null: true

      t.timestamps
    end
  end
end
