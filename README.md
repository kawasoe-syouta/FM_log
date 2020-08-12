# README

## Database creation
### users table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|image|string||
|surname|string|null: false|
|surname_kana|string|null: false|
|firstname|string|null: false|
|firstname_kana|string|null: false|
|nick_name|string|null: false, unique: true|
|Birthday|string|null: false|
|mail|string|null: false|
|password|string|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- has_one :street
- has_many :items
- has_many :messages
- has_many :credits

### items table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|sell_user_id|integer|null: false, foreign_key: true|
|buy_user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|phase_id|integer|null: false, foreign_key: true|
|status_id|integer|null: false, foreign_key: true|
|delivery_to_pay_id|integer|null: false, foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|item_detail|text||
|delivery_days|integer|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- has_many :item_images
- has_many :messages
- belongs_to :user, foreign_key: "sell_user_id", class_name: "User"
- belongs_to :user, foreign_key: "buy_user_id", class_name: "User"
- belongs_to :phase
- belongs_to :status
- belongs_to :delivery_to_pay
- belongs_to :category

### phases table
- use active_hash

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|phase|string|null: false|

#### Association
<!-- no association because use active_hash -->

### statuses table
- use active_hash

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|status|string|null: false|

#### Association
<!-- no association because use active_hash -->

### delivery_to_pays table
- use active_hash

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|to_pay|string|null: false|

#### Association
<!-- no association because use active_hash -->

### streets table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|user_id|integer|null: false, foreign_key: true|
|prefecture_id|string|null: false, foreign_key: true|
|postal_code|string|null: false, limit: 7|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|string|null: false, limit: 12|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- belongs_to :user
- belongs_to :prefecture

### prefectures table
- use active_hash

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|name|string|null: false|

#### Association
<!-- no association because use active_hash -->

### credits table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|user_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
|card_number|string|null: false, limit: 16|
|expiration|string|null: false, limit: 5|
|secret_code|string|null: false, limit: 3|
|card_surname|string|null: false|
|card_firstname|string|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- belongs_to :user

### brands table
- use active_hash

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|brand|string|null: false|

#### Association
<!-- no association because use active_hash -->

### messages table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|text|text|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- belongs_to :user
- belongs_to :item

### item_images table
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|item_id|integer|null: false, foreign_key: true|
|image|string|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- belongs_to :item

### categories table
- use ancestry

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|path|string||
|name|string|null: false|
|created_at|date|null: false|
|updated_at|date|null: false|

#### Association
- has_many :items