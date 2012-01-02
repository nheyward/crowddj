class AddTownToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :town, :string
  end

  def self.down
    remove_column :venues, :town
  end
end
