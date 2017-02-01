class ChangeTypeToDeviceType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :devices, :type, :device_type
  end
end
