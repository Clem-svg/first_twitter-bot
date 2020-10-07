require 'twitter'
require 'dotenv'# Appelle la gem Dotenv

Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
# et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV

# Il est ensuite très facile d'appeler les données du hash ENV, par exemple là je vais afficher le contenu de la clé TWITTER_API_SECRET
# puts ENV['TWITTER_API_SECRET']

#Autre exemple 
# puts ENV['BEST_WEBSITE_EVER']

client_rest = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

# ligne qui permet de tweeter sur ton compte
# client.update('Mon premier tweet en Ruby !')

# Send tweet to random among journalists
# sample_journalists = journalits.sample(2)

# soit : sample_journalists.each { |n| client.update("#{n} salut toi") }

# soit : client.update("#{sample_journalists[1]} hello ! hope you are well, sorry this is a kind test. thanks")

# # Like last 25 recent tweets 
# hello_tweet = client.search("#bonjour_monde -rt", result_type: "recent").take(25)
# client.favorite(hello_tweet)


# # follow last 20 users who have tweeted bonjour monde
# client.search("#bonjour_monde -rt", result_type: "recent").take(10).each do |tweet|
# client.follow(tweet.user.screen_name)
# end


client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end 

topics = ["ficus"]
client.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
  client_rest.favorite(object)
  client_rest.follow(object.user.screen_name)
end

