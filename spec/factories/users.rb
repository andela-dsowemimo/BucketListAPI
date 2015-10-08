FactoryGirl.define do
  factory :user do
    name "Daisi Sowemimo"
    email "daisi.sowemimo@andela.com"
    auth_token "My212aut1wer2hdvs"
    password "railsrules"
    password_confirmation "railsrules"

    factory :invalid_user do
      email nil
      password "hello"
      password_confirmation "not_hello"
    end

    factory :new_user do
      auth_token nil
    end

    factory :second_user do
      name  "Tolani Ajayi"
      email "tolaniajayi@yahoo.com"
      auth_token "nasdwjd212e"
      password "weliveforever"
      password_confirmation "weliveforever"
    end

    factory :update_user do
      name "Daisi Sowemimo"
      email "daisi.sowemimo@google.com"
      auth_token "My212aut12hdvs"
      password "railsrulesforever"
      password_confirmation "railsrulesforever"
    end
  end

end
