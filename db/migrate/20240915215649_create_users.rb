class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :external_id, null: false
      t.string :display_name, null: false

      t.timestamps
    end

    add_index :users, :external_id, unique: true
  end
end
