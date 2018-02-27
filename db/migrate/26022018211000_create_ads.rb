class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.integer :campaign_id, index:true, foreign_key: true
      t.integer :status, null: false
      t.string :reference, null: false
      t.timestamps null: false
    end
  end
end