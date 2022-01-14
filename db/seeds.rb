# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'

# generate 20 articles
(1..300).each do |id|
    Article.create!(
        id: id, 
        title: Faker::Company.catch_phrase,
        body: Faker::Lorem.paragraph_by_chars(number: 650),
        image_url: Faker::LoremFlickr.image(size: "500x500", search_terms: ['nature']) + '?random=' + Faker::Number.number(digits: 5).to_s,
        created_at: Faker::Date.between(from: 300.days.ago, to: Date.today)
    )
end