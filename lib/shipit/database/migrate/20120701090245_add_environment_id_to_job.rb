class AddEnvironmentIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :environment_id, :integer
  end
end
