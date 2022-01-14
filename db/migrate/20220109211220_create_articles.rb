class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body
      t.string :image_url
      t.timestamps
    end
  end
end
