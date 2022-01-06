FactoryBot.define do
  factory :fellowship do
    id { "" }
    name { "MyString" }
    description { "MyText" }
    created_at { "2022-01-06 15:36:27" }
    updated_at { "2022-01-06 15:36:27" }
    organization_id { 1 }
    author_id { 1 }
    responsible_id { 1 }
    flags_count { 1 }
    geozone_id { 1 }
    community_id { 1 }
    clear_name { false }
  end
end
