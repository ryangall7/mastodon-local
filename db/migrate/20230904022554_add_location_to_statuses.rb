# frozen_string_literal: true

class AddLocationToStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :statuses, :location, :st_point, geographic: true
  end
end
