# Seed file for Schools
puts "Seeding schools..."

schools = []

["Harvard University", "Moscow University"].each do |school|
  School.find_or_create_by!(name: school)
  schools << school
end

puts "Schools created: #{schools.join(", ")}"

puts "Schools seeding completed!" 