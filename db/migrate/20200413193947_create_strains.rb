class CreateStrains < ActiveRecord::Migration[6.0]
  def change
    create_table :strains do |t|
      t.string :name
      t.string :description
      t.string :flavors
      t.string :genus
      t.string :effects

      t.timestamps
    end
  end
end
