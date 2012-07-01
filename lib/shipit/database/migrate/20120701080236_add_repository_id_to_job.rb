class AddRepositoryIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :repository_id, :integer
  end
end
