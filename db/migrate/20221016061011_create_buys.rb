class CreateBuys < ActiveRecord::Migration[6.0]
  def change
    create_table :buys do |t|
      t.references :user,    null: false, foregin_key: true
      t.references :product, null: false, foregin_key: true
      t.timestamps
    end
  end
end
