class CreateMutuals < ActiveRecord::Migration[5.2]
  def change
    create_table :mutuals do |t|
      t.references :users
      t.references :vaults
      t.datetime :expire_at
      t.timestamps
    end
  end
end
