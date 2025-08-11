# Seed file for Terms
puts "Seeding terms..."

school_harvard = School.find_by(name: "Harvard University")
school_moscow = School.find_by(name: "Moscow University")

result = []

["Spring 2027", "Summer 2027"].each do |term_name|
  term = Term.find_or_create_by!(name: term_name) do |t|
    t.school = school_harvard
  end 

  result << term.name
end

["Spring 2028", "Summer 2028", "Fall 2028"].each do |term_name|
  term = Term.find_or_create_by!(name: term_name) do |t|
    t.school = school_moscow
  end 

  result << term.name
end

puts "Terms created: #{result.join(", ")}"

puts "Terms seeding completed!"