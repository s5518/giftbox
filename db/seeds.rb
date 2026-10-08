# 1. テストユーザー
User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

# 2. 管理者ユーザー
Admin.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)
