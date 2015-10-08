FactoryGirl.define do
  factory :bucketlist do
    name "Things to get done before I turn 30"
    association :user

    factory :bucketlist_one do
      name "Things to do before the year ends"
      association :user
    end

    factory :unowned_bucketlist do
      name "Things to do before I graduate"
    end

    factory :another_bucketlist do
      name "Things to do for the Lord"
    end
  end


end
