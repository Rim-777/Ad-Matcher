class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.integer :verification_id, index: true, foreign_key: true, null: false
      t.string :self_reference, null: false
      t.string :external_reference, null: false
      t.integer :status, null: false
      t.index([:verification_id, :external_reference])
      t.timestamps null: false
    end
  end
end
