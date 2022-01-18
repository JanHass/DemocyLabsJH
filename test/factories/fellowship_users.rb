FactoryBot.define do
  factory :fellowship_user do
    fellowship_id { 1 }
    user_id { 1 }
    is_fellowship_administrator { false }
    is_fellowship_moderator { false }
  end
end
