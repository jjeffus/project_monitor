class CreatePivotalReports < ActiveRecord::Migration
  def change
    create_table :pivotal_reports do |t|

      t.timestamps
    end
  end
end
