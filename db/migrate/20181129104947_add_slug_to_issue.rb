class AddSlugToIssue < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :slug, :string
  end
end
