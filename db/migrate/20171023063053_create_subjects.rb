class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.integer :teacher_id,  null: false
      t.string  :name			 ,	null: false

      t.timestamps
    end

    add_index :subjects, :teacher_id
  end
end
