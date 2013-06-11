class CreateGithubReports < ActiveRecord::Migration
  def change
    create_table :github_reports do |t|

      t.timestamps
    end
  end
end
