# Seed file for Courses
puts "Seeding courses..."

term_school_harvard = Term.find_by(name: "Spring 2027")
term_school_moscow = Term.find_by(name: "Summer 2028")

result = []

["Math for Nerds", "Physics", "Learn to Code Like a Badass"].each do |course_name|
  course = Course.find_or_create_by!(name: course_name) do |c|
    c.term = term_school_harvard
  end

  result << course.name
end

["Cooking 101", "How to Spot a Giraffe", "Ancient History of Burritos"].each do |course_name|
  course = Course.find_or_create_by!(name: course_name) do |c|
    c.term = term_school_moscow
  end

  result << course.name
end

puts "Courses created: #{result.join(", ")}"

puts "Courses seeding completed!"