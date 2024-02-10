# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

json = JSON.parse(URI.open('https://tmdb.lewagon.com/movie/popular').read)

json['results'].each do |m|
  movie = Movie.new
  movie.title = m['original_title']
  movie.overview = m['overview']
  movie.poster_url = "https://image.tmdb.org/t/p/w500#{m['poster_path']}"
  movie.rating = m['vote_average']
  movie.save!
  puts "Adding #{movie.title}"
end
