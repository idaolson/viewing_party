class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.date :day
      t.time :time
      t.integer :duration

      t.timestamps
    end
  end
end
