class AddExtraToDevices < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :extra, :string
  end
end
