class CreateUserroomreads < ActiveRecord::Migration[6.0]
  def change
    create_table :userroomreads do |t|
      t.string :room_id
      t.string :user_id
      t.integer :unread
      t.timestamps
    end
  end
end
