class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :external_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :teams, :external_id, unique: true
  end
end
