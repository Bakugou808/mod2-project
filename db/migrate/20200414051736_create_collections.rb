class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :user_id
      t.string :strain_id

      t.timestamps
    end
  end
end