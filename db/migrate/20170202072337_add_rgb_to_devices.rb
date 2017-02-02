class AddRgbToDevices < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :red_pin, :integer
    add_column :devices, :green_pin, :integer
    add_column :devices, :blue_pin, :integer
  end
end
