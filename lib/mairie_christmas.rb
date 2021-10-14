require 'rubygems'
require 'nokogiri'
require 'open-uri'

# 1-Collecte de l'email d'une mairie d'une ville du Val d'Oise
def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(open(townhall_url)) 
	email_array = []

	email = page.xpath('//*[contains(text(), "@")]').text
    town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split 
# On divise la string pour pouvoir récupérer uniquement le nom de la vile

    email_array << {town[3] => email} 
# On indique la position du nom de la ville dans la string pour la récupérer
	puts email_array
	return email_array
end   
    

# 2-Collecte des URL de toutes les villes du 9-5
def get_townhall_urls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	url_array = []

	urls = page.xpath('//*[@class="lientxt"]/@href') 

    urls.each do |url| 
# ->Pour chaque URL récupérée : indiquer l'url parent "http://annuaire-des-mairies.com"
        url = "http://annuaire-des-mairies.com" + url.text[1..-1] 
#->A l'url parent, on ajoute les urls récupérées du deuxième caractère au dernier caractère, car on veut se débarasser du point devant.
		url_array << url		
	end
	return url_array 
end


# 3- Liaison villes et mails
def scrap_data
	url_array = get_townhall_urls 
    url_array.each do |townhall_url| 
# -> Pour chaque URL d'une ville du Val d'Oise, on associe l'adresse mail de la mairie
		get_townhall_email(townhall_url)
	end
end 


scrap_data