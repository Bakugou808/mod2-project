class AddColumnToStrains < ActiveRecord::Migration[6.0]
  def change
    add_column :strains, :likes, :integer, default: 0
  end
end
