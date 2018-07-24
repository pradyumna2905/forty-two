class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records, id: :uuid do |t|
      t.text :definitions
      t.text :examples
      t.belongs_to :entry

      t.timestamps
    end
  end
end
