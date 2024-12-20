User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now,
)

99.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "example-#{n+1}@railstutorial.org",
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now,
  )
end

# マイクロポスト
users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |u| u.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user = users.first
users[2..50].each { |other| user.follow(other) } # フォロー
users[3..40].each { |other| other.follow(user) } # フォロワー
