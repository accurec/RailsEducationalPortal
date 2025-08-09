# Seed file for Licenses
puts "Seeding licenses..."

licenses = []

["license_code1", "license_code2", "license_code3"].each do |license_code|
  License.find_or_create_by!(code: license_code)
  licenses << license_code
end

puts "Licenses created: #{licenses.join(", ")}"

puts "Licenses seeding completed!"