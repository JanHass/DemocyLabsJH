FactoryBot.define do
  factory :fellowship do
    name { "MyString" }
    email { "MyString" }
    description { "MyText" }
    created_at { "2022-01-16 09:16:26" }
    updatet_at { "2022-01-16 09:16:26" }
    organization_id { 1 }
    user_id { 1 }
    author_id { 1 }
    responsible_id { 1 }
    flags_count { 1 }
    geozone_id { 1 }
    community_id { 1 }
    clear_name { false }
    user_required_full_name { false }
    user_required_phone_number { false }
    user_required_gender { false }
    user_required_date_of_birth { false }
    user_required_adress { false }
    user_required_state { false }
    user_required_city { false }
    user_required_country { false }
    user_public_show_full_name { false }
    user_public_show_phone_number { false }
    user_public_show_gender { false }
    user_public_show_date_of_birth { false }
    user_public_show_address { false }
    user_public_show_state { false }
    user_public_show_city { false }
    user_public_show_country { false }
    admin_required_full_name { false }
    admin_required_phone_number { false }
    admin_required_gender { false }
    admin_required_date_of_birth { false }
    admin_required_address { false }
    admin_required_state { false }
    admin_required_city { false }
    admin_required_country { false }
    admin_public_show_full_name { false }
    admin_public_show_phone_number { false }
    admin_public_show_gender { false }
    admin_public_show_date_of_birth { false }
    admin_public_show_address { false }
    admin_public_show_state { false }
    admin_public_show_city { false }
    admin_public_show_country { false }
  end
end
