class CreateLabResults < ActiveRecord::Migration[6.0]
  def change
    create_table :lab_results do |t|
      t.integer :strain_id
      t.string :name
      t.string :chem_profile

      t.timestamps
    end
  end
end
