class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :room_id
      t.string :user_id
      t.timestamps

    end
  end
end
