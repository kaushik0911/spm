class CreateVaults < ActiveRecord::Migration[5.2]
  def change
    create_table :vaults do |t|
      t.string :username
      t.string :password
      t.text :note
      t.references :users
      t.timestamps
    end
  end
end
