FactoryGirl.define do
  factory :student do
    first_name "MyString"
    last_name "MyString"
    sid "MyString"
    transfer_student false
    concurrency_student false
  end
end
