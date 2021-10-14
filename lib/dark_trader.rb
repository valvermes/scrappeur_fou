require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Récupération de l'url de la page
def get_page
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    return page
end

# Récupération des noms de monnaie
def scrap_symbols
  page = get_page
  symbols = page.xpath('//*[@class="text-left col-symbol"]')
  symbols_array = [] #Initialisation d'un array pour stockage
  symbols.each do |symbol| 
    symbols_array << symbol.text
# On met .text pour les avoir en string     
	end
	return symbols_array
end


# Récupération des prix
def scrap_prices
	page = get_page
	prices = page.xpath('//*[@class="price"]')
	prices_array = []
	prices.each do |price|
		prices_array << price.text
	end
	return prices_array
end  


# Liaison monnaies et prix
def trader

# Rappel des methodes :
	symbols_array = scrap_symbols 
	prices_array = scrap_prices 
	a = [] # Initialisation d'un array pour les stocker

	symbols_array.each_with_index do |x, y|	
	# -> On associe pour chaque item de symbols_array un item de prices_array
		a << {x => (prices_array)[y]} 
	# -> On sauvegarde sous forme d'hash dans le tableau
	end
	print a
	return a 
end

trader



