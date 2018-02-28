class CreateVerifications < ActiveRecord::Migration[5.0]
  def change
    create_table :verifications do |t|
      t.jsonb :campaign_list,  null: false
      t.timestamps null: false
    end
  end
end
