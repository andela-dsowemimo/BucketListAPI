FactoryGirl.define do
  factory :item do
    name "Get Married"
    done false
    association :bucketlist

    factory :item_two do
      name "Buy House"
      done true
    end

    factory :item_three do
      name "Get a tattoo"
      done false
    end
  end

end
