require 'rubygems'
require 'nokogiri'
require 'open-uri'

# cryptocurrencies methode
def cryptocurrencies
    crypto_links = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    element_target_line = crypto_links.css("table#currencies-all tbody tr")
    element_target_size = element_target_line.size
    result_array = []
    items_hash = Hash.new

# Parcourir chaque ligne pour récuperer chaque élement de la 2ème et 4ème colonne
    element_target_line.length.times do  |items| 
        keys = element_target_line[items].css("td")[2].text
        value = element_target_line[items].css("td")[4].text[2...element_target_line[items].css("td")[4].text.size - 2].to_f.round(2)
        items_hash[keys] = items_hash[value]
        result_array << items_hash
        items_hash = Hash.new
    end
return result_array # Retourne la resultat
end

print cryptocurrencies
