class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.text :content
      t.belongs_to :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
