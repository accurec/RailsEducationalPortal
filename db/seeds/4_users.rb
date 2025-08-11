# Seed file for Users
puts "Seeding users..."

# Create admin users
admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :admin
end

puts "Admin user created: #{admin_user.email}"

school_harvard = School.find_by(name: "Harvard University")

# Create student users
student1 = User.find_or_create_by!(email: "student1@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :student
  user.school = school_harvard
end

school_moscow = School.find_by(name: "Moscow University")

moscow_students = []

[
  "student2@example.com",
  "student3@example.com",
  "student4@example.com"
].each do |email|
  student = User.find_or_create_by!(email: email) do |user|
    user.password = "password123"
    user.password_confirmation = "password123"
    user.role = :student
    user.school = school_moscow
  end

  moscow_students << student.email
end

puts "Student users created: #{student1.email}, #{moscow_students.join(', ')}"
puts "Users seeding completed!" 