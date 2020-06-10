User.create!(name:  "Example User",
             email: "example@tomalog.com",
             password:              "tomalogpass",
             password_confirmation: "tomalogpass",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@tomalog.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end