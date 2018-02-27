class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :verification_id,
                index: true,
                foreign_key: true,
                null: false
      t.text :message, null: false
      t.timestamps null: false
    end
  end
end
