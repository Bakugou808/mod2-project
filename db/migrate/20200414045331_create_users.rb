class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :interests
      t.string :favorites

      t.timestamps
    end
  end
end
