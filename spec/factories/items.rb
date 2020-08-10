FactoryBot.define do
  factory :item do
    sell_user
    buy_user
    category
    phase_id {1}
    status_id {1}
    delivery_to_pay_id {1}
    name {'sample'}
    price {1000}
    item_detail {"test"}
    delivery_days {3}
  end

  factory :sell_user, class: User do
    
  end

  factory :buy_user, class: User do
    
  end

  factory :category, class: Category do
    
  end
end