FactoryBot.define do
  factory :task do
    title { Faker::Name.name }

    trait :due_soon do
      due_date { 3.days.from_now }
    end
  end
end
