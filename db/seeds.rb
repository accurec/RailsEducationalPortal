# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Starting database seeding..."

# Load all seed files from db/seeds directory
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed_file|
  puts "Loading #{File.basename(seed_file)}..."
  load seed_file
end

puts "Database seeded successfully!"
