# Seed file for Schools
puts "Seeding schools..."

school_harvard = School.find_or_create_by!(name: "Harvard University")
school_moscow = School.find_or_create_by!(name: "Moscow University")

puts "Schools created: #{school_harvard.name}, #{school_moscow.name}"

puts "Schools seeding completed!" 