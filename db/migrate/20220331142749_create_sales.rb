class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.date :date
      t.string :item
      t.integer :item_quantity

      t.timestamps
    end
  end
end
