class CreateUserchats < ActiveRecord::Migration[6.0]
  def change
    create_table :userchats do |t|
      t.string :room_id
      t.string :user_id

      t.timestamps
    end
  end
end
