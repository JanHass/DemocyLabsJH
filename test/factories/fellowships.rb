FactoryBot.define do
  factory :fellowship do
    name { "MyString" }
    description { "MyText" }
    created_at { "2022-01-07 09:28:22" }
    updated_at { "2022-01-07 09:28:22" }
    organization_id { 1 }
    community_id { 1 }
    author_id { 1 }
    responsible_id { 1 }
    flags_count { 1 }
    geozone_id { 1 }
    postalcode_id { 1 }
    clear_name { false }
    complex_auth_code { "MyString" }
  end
end
