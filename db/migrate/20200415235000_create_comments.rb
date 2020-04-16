class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :strain_id
      t.string :comment

      t.timestamps
    end
  end
end