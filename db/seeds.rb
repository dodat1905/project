User.create!(email: "dodat1905@gmail.com",
  password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now,
  profile_attributes: {name: "Đỗ Quốc Đạt", age: "20",
    address: "394 Bạch Đằng, Chương Dương, Hoàn Kiếm, Hà Nội"})

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  address = Faker::Address.street_address
  age = "21"
  User.create!(email: email, password: password,
    password_confirmation: password, activated: true,
    activated_at: Time.zone.now,
    profile_attributes: {name: name, age: "20",
      address: address})
end

users = User.order(:created_at).take(6)
50.times do 
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content)}
end
