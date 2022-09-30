class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string     :title,           null: false
      t.text       :content,         null: false
      t.integer    :category_id,     null: false
      t.integer    :condition_id,    null: false
      t.integer    :postage_id,      null: false
      t.integer    :area_id,         null: false
      t.integer    :shipping_day_id, null: false
      t.integer    :price,           null: false
      t.references :user,            null: false, foregin_key: true
      t.timestamps
    end
  end
end
