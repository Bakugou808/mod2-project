class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.integer :collection_id
      t.string :note
      t.integer :rating
      t.string :vendor
      t.string :date

      t.timestamps
    end
  end
end
