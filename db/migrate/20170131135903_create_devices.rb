class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.integer :pin
      t.string :icon
      t.string :state
      t.string :type
      t.integer :brightness
      t.string :color
      t.string :multicolor
      t.integer :speed
      t.belongs_to :room, index: true
      t.timestamps
    end
  end
end
