class AddFlagsToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :flag_url, :string
  end
end
