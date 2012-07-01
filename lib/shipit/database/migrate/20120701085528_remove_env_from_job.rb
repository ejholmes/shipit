class RemoveEnvFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :env
    remove_column :jobs, :repository_id
  end

  def down
  end
end
