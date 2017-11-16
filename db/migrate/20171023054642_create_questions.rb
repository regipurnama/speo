class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
    	t.integer :subject_id, null:false
    	t.string  :title		 , null: false
    	t.text		:key			 , null: false

    	t.timestamps 
    end

    add_index :questions, :subject_id
  end
end
