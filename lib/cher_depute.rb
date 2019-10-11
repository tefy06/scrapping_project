require 'nokogiri'
require 'open-uri'


def get_infos(url)
  page = Nokogiri::HTML(open(url))
  
  res = Hash.new

  # recuperation des données
  name = page.xpath('/html/body/div[1]/div[3]/div/div/div/section[1]/div/article/div[2]/h1')
  name_array = name.text.split(' ')
  email = page.xpath('/html/body/div[1]/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a')

  # génération du Hash contenant les données
  res['first_name'] = name_array[1]
  res['last_name'] = name_array[2]
  res['email'] = email.text

  return res

end


def get_links
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  
  # récupération des liens
  puts "Start scraping..."
  links = page.xpath('//*[@id="deputes-list"]//li/a')
  
  return links

end

#get_links

def generate_depute_infos
  base_url = 'http://www2.assemblee-nationale.fr'
  results = []
  i = 0
  limit = 5

  # récupération des données dans un tableau
  get_links.each do |link|
    # impose une limite car trop long
    if i > limit
      break
    end

    url = base_url + link['href']
    results << get_infos(url)

    print '.'
    i += 1
  end

  puts ""
  puts "=== RESULT ==="
  return results

end

# execution
p generate_depute_infos
