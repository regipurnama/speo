class CreateHighScores < ActiveRecord::Migration[5.1]
  def change
    create_table :high_scores do |t|
      t.string :game
      t.integer :score
      t.integer :level

      t.timestamps
    end
  end
end
