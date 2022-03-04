FactoryBot.define do
  factory :pro_contra do
    tag { "MyString" }
    body { "MyText" }
    sources { "MyText" }
    email { "MyString" }
    rating { 1.5 }
    likes { 1 }
    dislikes { 1 }
    reported { 1 }
    move { 1 }
    pc { 1 }
    user { nil }
    debate { nil }
    proposal { nil }
    poll { nil }
    vote { nil }
    fellowship { nil }
  end
end
