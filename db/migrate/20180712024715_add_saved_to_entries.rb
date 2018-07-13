class AddSavedToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :saved, :boolean, default: false
  end
end
