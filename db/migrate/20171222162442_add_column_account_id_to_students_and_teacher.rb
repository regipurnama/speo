class AddColumnAccountIdToStudentsAndTeacher < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :account_id, :integer,after: :id
    add_column :students, :account_id, :integer,after: :id
  end
end
