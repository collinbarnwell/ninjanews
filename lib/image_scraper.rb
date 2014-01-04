require 'nokogiri'
require 'open-uri'

class ImageScraper
  def self.get_image(article)
    page = Nokogiri::HTML(open(article.url))
    images = page.css('img').select do |img|
      img[:src] if img[:width].to_i >= 300 && img[:height].to_i >= 300
    end

    unless images.blank?
      image = images.first['src']
      File.open('temp.png', 'wb') { |f| f.write(open(image).read) }
      article.image = File.open('temp.png')
      article.save!
      File.delete('temp.png')

      puts 'Image added.'      
    end
  end
end