class AddPivotalDataToPivotalReport < ActiveRecord::Migration
  def change
  	add_column :pivotal_reports, :pivotal_data, :text
  end
end
