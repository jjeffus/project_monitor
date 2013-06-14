class AddGithubDataToGithubReport < ActiveRecord::Migration
  def change
    add_column :github_reports, :github_data, :text
  end
end
