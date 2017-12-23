class AddColumnAccountableToAccount < ActiveRecord::Migration[5.1]
  def up
    change_table :accounts do |t|
      t.references :accountable, polymorphic: true
    end
  end
end
