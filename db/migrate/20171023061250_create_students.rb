class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.integer :grade_id , null: false
      t.string  :name			, null: false
      t.string  :gender		, null: false

      t.timestamps
    end

    add_index :students, :grade_id
  end
end
