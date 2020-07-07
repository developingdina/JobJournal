class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :company_name
      t.string :position_title
      t.datetime :applied
      t.string :description
      t.integer :user_id
    end
  end
end
