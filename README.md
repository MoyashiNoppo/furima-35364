# テーブル設計

## users テーブル
| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| nickname           | string   | null: false                   |
| email              | string   | null: false, unique: true     |
| encrypted_password | string   | null: false                   |
| family_name        | string   | null: false                   |
| first_name         | string   | null: false                   |
| family_name_kana   | string   | null: false                   |
| first_name_kana    | string   | null: false                   |
| birth              | date     | null: false                   |

### Association

- has_many :items
- has_many :purchases


## items
| Column               | Type            | Options                        |
| -------------------- | --------------- | ------------------------------ |
| item_name            | string          | null: false                    |
| description          | text            | null: false                    |
| category_id          | integer         | null: false                    |
| condition_id         | integer         | null: false                    |
| shipping_charge_id   | integer         | null: false                    |
| ship_from_area_id    | integer         | null: false                    |
| days_to_ship_id      | integer         | null: false                    |
| price                | integer         | null: false                    |
| user                 | references      | null: false, foreign_key: true |

### Association

- belong_to :user
- has_one  :purchase


## purchases
| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :item
- has_one   :shipping


## shippings
| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| postal_code       | string     | null: false                    |
| prefecture_id     | integer    | null: false                    |
| municipality      | string     | null; false                    |
| address           | string     | null; false                    |
| building_name     | string     |                                |
| phone_number      | string     | null; false                    |
| purchase          | references | null: false, foreign_key: true |

### Association
- belong_to :purchase