class CreateDictionaries < ActiveRecord::Migration[5.2]
  def change
    create_table :dictionaries, id: :uuid do |t|
      t.string :word
      t.text :response

      t.timestamps
    end
  end
end
