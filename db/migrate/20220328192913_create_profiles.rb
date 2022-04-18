class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :image_url 
      t.text :bio
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
