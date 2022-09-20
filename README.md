## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many :products

***

## productsテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| title        | string     | null: false                    |
| content      | text       | null: false                    |
| category     | string     | null: false                    |
| condition	   | string	    | null: false                    |
| postage      | string     | null: false                    |
| area         | string     | null: false                    |
| shipping_day | string     | null: false                    |
| price	       | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association
- belong_to :users
- has_one   :buys

***

## buysテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association
- belong_to :users
- belong_to :products
- belong_to :addresses

***

## addressesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postcode       | string	    | null: false                    |
| prefectures    | string     | null: false                    |
| municipalities | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     |                                |
| phone          | integer    | null: false                    |
| buys           | references | null: false, foreign_key: true |

### Association
- has_many :buys