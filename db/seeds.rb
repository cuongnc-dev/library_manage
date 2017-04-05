Category.create!(
  name: "Kinh doanh"
)

Category.create!(
  name: "Ngôn tình"
)

Category.create!(
  name: "Kỹ năng"
)

Category.create!(
  name: "Tủ sách gia đình"
)

Category.create!(
  name: "Văn học"
)

Category.create!(
  name: "Nhân vật - Sự kiện"
)

Category.create!(
  name: "Văn hóa - Xã hội"
)

Category.create!(
  name: "Khoa học - Công nghệ"
)

Category.create!(
  name: "Thiếu nhi"
)

Category.create!(
  name: "Tạp chí - Chuyên đề"
)

Subcategory.create!(
  category_id: 1,
  name: "Khởi nghiệp"
)

Subcategory.create!(
  category_id: 1,
  name: "Maketing - Bán hàng"
)

Subcategory.create!(
  category_id: 1,
  name: "Quản trị - Lãnh đạo"
)

Subcategory.create!(
  category_id: 1,
  name: "Đầu tư - Tài chính"
)

Subcategory.create!(
  category_id: 1,
  name: "Kiến thức kinh tế"
)

Subcategory.create!(
  category_id: 1,
  name: "Kinh doanh tổng hợp"
)

Subcategory.create!(
  category_id: 2,
  name: "Cổ trang"
)

Subcategory.create!(
  category_id: 2,
  name: "Hiện đại"
)

Subcategory.create!(
  category_id: 2,
  name: "Xuyên không"
)

Subcategory.create!(
  category_id: 2,
  name: "Trọng sinh"
)

Subcategory.create!(
  category_id: 2,
  name: "Huyền ảo"
)

Subcategory.create!(
  category_id: 3,
  name: "Nghệ thuật sống"
)

Subcategory.create!(
  category_id: 3,
  name: "Kỹ năng làm việc"
)

Subcategory.create!(
  category_id: 3,
  name: "Hướng nghiệp"
)

Subcategory.create!(
  category_id: 3,
  name: "Kỹ năng sống"
)

Subcategory.create!(
  category_id: 4,
  name: "Chăm sóc sức khỏe"
)

Subcategory.create!(
  category_id: 4,
  name: "Nuôi dạy con"
)

Subcategory.create!(
  category_id: 4,
  name: "Tâm lý - Giới tính"
)

Subcategory.create!(
  category_id: 4,
  name: "Phụ nữ - Làm đẹp"
)

Subcategory.create!(
  category_id: 5,
  name: "Thơ - Tản văn"
)

Subcategory.create!(
  category_id: 5,
  name: "Truyện dài - Tiểu thuyết"
)

Subcategory.create!(
  category_id: 5,
  name: "Trinh thám"
)

Subcategory.create!(
  category_id: 5,
  name: "Kiếm hiệp"
)

Subcategory.create!(
  category_id: 5,
  name: "Truyện ngắn"
)

Subcategory.create!(
  category_id: 5,
  name: "Hài hước"
)

Subcategory.create!(
  category_id: 5,
  name: "Tâm lý"
)

Subcategory.create!(
  category_id: 5,
  name: "Gỉa tưởng"
)

Subcategory.create!(
  category_id: 5,
  name: "Tự truyện"
)

Subcategory.create!(
  category_id: 5,
  name: "Kinh dị"
)

Subcategory.create!(
  category_id: 6,
  name: "Nhân vật"
)

Subcategory.create!(
  category_id: 6,
  name: "Sự kiện"
)

Subcategory.create!(
  category_id: 7,
  name: "Chính trị - Pháp luật"
)

Subcategory.create!(
  category_id: 7,
  name: "Tôn giáo - Tâm linh"
)

Subcategory.create!(
  category_id: 7,
  name: "Khoa học xã hội"
)

Subcategory.create!(
  category_id: 7,
  name: "Văn hóa nghệ thuật"
)

Subcategory.create!(
  category_id: 7,
  name: "Giáo dục"
)

Subcategory.create!(
  category_id: 8,
  name: "Khoa học - Công nghệ"
)

Subcategory.create!(
  category_id: 8,
  name: "Kiến thức khoa học"
)

Subcategory.create!(
  category_id: 9,
  name: "Cổ tích - Thần thoại"
)

Subcategory.create!(
  category_id: 9,
  name: "Bài học cuộc sống"
)

Subcategory.create!(
  category_id: 9,
  name: "Văn học thiếu nhi"
)

Subcategory.create!(
  category_id: 10,
  name: "Tạp chí"
)
Subcategory.create!(
  category_id: 10,
  name: "Chuyên đề"
)


9.times do |n|
  name  = Faker::Name.name
  email = "publisher-#{n+1}@publisher.com"
  phone = "012345678#{n+1}"
  address = "publisher-address-#{n+1}"
  Publisher.create!(
    name:  name,
    email:  email,
    phone: phone,
    address: address,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

9.times do |n|
  3.times do |m|
    name  = Faker::Name.name
    email = "author-#{(n+1)*(m+1)}@author.com"
    phone = "098765432#{(n+1)*(m+1)}"
    address = "author-address-#{n+1}"
    publisher_id = n+1;
    Author.create!(
      name:  name,
      email:  email,
      phone: phone,
      address: address,
      publisher_id: publisher_id,
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    )
  end
end

User.create!(
  name: "Nguyễn Cao Cường",
  email: "cuongnc.ltv@gmail.com",
  password: "132123",
  password_confirmation: "132123",
  is_admin: true,
  created_at: Time.zone.now,
  activated: true
)
