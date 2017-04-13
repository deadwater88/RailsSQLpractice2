class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :poll_id, null: false
      t.index :poll_id
      t.timestamps
    end
  end
end
