class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end
