class CreateElanceReports < ActiveRecord::Migration
  def change
    create_table :elance_reports do |t|

      t.timestamps
    end
  end
end
