# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# #system seeds
User.destroy_all
Game.destroy_all
GameSystem.destroy_all
System.destroy_all
SystemUser.destroy_all

url = "https://api.rawg.io/api/platforms"
response = RestClient.get(url)
data = JSON.parse(response)

data["results"].each do |system|
    id = system["id"]
    name = system["name"]
    System.create(name: name, id: id)
end

# game seeds
Game.destroy_all
GameSystem.destroy_all

url = "https://api.rawg.io/api/games?page=1"
response = RestClient.get(url)
data = JSON.parse(response)

data["results"][0..9].each do |game|
    name = game["name"]
    rating = game["rating"]
    esrb_rating = "everyone"
    rating_count = game["reviews_count"]
    genre = game["genres"][0]["name"]
    platform_ids = game["platforms"].map{|platform| platform["platform"]["id"]}
    image_url = game["background_image"]
    game = Game.create(name: name, rating: rating, esrb_rating: esrb_rating, rating_count: rating_count, genre: genre, image_url:image_url)
    platform_ids.each do |platform_id|
        GameSystem.create(game_id: game.id, system_id: platform_id)
    end
end



#user seeds
sisan = User.create(name: "Sisan", age: 21, interest: "Horror and Adventure games")
reid = User.create(name: "Reid", age: 26, interest: "Fantasy and Strategy games")
bill = User.create(name: "Bill", age: 31, interest: "pokemon")
greg = User.create(name: "Greg", age: 31, interest: "codin'")
caryn = User.create(name: "Caryn", age: 26, interest: "cats")