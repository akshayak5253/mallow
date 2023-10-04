FactoryBot.define do
  factory :posts_users_read_status do
    read { false }
    user { nil }
    post { nil }
  end
end
