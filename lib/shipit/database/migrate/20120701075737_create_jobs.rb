class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :env
      t.string :output

      t.timestamps
    end
  end
end
