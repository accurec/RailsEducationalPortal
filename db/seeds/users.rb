# Seed file for Users
puts "Seeding users..."

# Create admin users
admin_user = User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :admin
end

puts "Admin user created: #{admin_user.email}"

# Create student users
student1 = User.find_or_create_by!(email: 'student1@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :student
end

student2 = User.find_or_create_by!(email: 'student2@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :student
end

puts "Student users created: #{student1.email}, #{student2.email}"
puts "Users seeding completed!" 