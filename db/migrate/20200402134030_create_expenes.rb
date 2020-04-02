class CreateExpenes < ActiveRecord::Migration[6.0]
  def change
    create_table :expenes do |t|
      t.integer :journal_id

      t.timestamps
    end
  end
end
