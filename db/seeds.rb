User.create!(name: "Đỗ Quốc Đạt", email: "dodat1905@gmail.com",
  password: "123456", password_confirmation: "123456",
  age: "20", address: "394 Bạch Đằng, Chương Dương, Hoàn Kiếm, Hà Nội",
  admin: true, activated: true, activated_at: Time.zone.now)

25.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  address = Faker::Address.street_address
  age = "21"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, age: age,
    address: address, activated: true, activated_at: Time.zone.now)
end
