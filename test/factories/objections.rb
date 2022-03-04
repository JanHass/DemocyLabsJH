FactoryBot.define do
  factory :objection do
    body { "MyText" }
    sources { "MyText" }
    email { "MyString" }
    rating { 1.5 }
    likes { 1 }
    dislikes { 1 }
    reported { 1 }
    user { nil }
    pro_contra { nil }
  end
end
