class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries, id: :uuid do |t|
      t.string :word
      t.text :definitions
      t.belongs_to :user

      t.timestamps
    end
  end
end
