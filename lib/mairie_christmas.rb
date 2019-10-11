require 'nokogiri'
require 'open-uri'

# methode de récuperation des email
def get_townhall_email(url)
  page = Nokogiri::HTML(open(url))
  
  email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  
  return email.text

end

# methode de récupération des liens
def get_townhall_links
  page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

  puts "Scraping..."
  links = page.xpath('/html/body/table//a[@class="lientxt"]')
  
  return links
end

# methode de génération du tableau de résultat final
def generate_town_email
  base_url = "https://www.annuaire-des-mairies.com"
  results = []

  # impose une limite car trop long
  limit = 5 
  i = 0
  
  # génération du tableau contenant les Hash contenant les données
  get_townhall_links.each do |link|

    if i > limit
      break
    end

    # génération du Hash contenant les données
    hash = Hash.new
    hash[link.text] = get_townhall_email(link['href'].sub(/^./, base_url))
    results << hash

    print "."
    i += 1
  end

  puts ""
  puts "=== RESULT ==="
  return results

end

# execution
p generate_town_email

