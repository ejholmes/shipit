class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
