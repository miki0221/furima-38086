## usersテーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false,              |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |
| last_name_kanji       | string  | null: false               |
| first_name_kanji      | string  | null: false               |
| last_name_kana        | string  | null: false               |
| first_name_kana       | string  | null: false               |
| birth_id              | date    | null: false               |

### Association
- has_many :products
- has_many :buys

***

## productsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| title           | string     | null: false                    |
| content         | text       | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id	  | integer    | null: false                    |
| postage_id      | integer    | null: false                    |
| area_id         | integer    | null: false                    |
| shipping_day_id | integer    | null: false                    |
| price	          | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :buy

***

## buysテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association
- belong_to :user
- belong_to :product
- has_one   :address

***

## addressesテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postcode     | string	    | null: false                    |
| area_id      | integer    | null: false                    |
| municipality | string     | null: false                    |
| address      | string     | null: false                    |
| building     | string     |                                |
| phone        | string     | null: false                    |
| buy          | references | null: false, foreign_key: true |

### Association
- belong_to :buy