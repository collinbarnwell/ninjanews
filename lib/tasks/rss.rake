require 'rss'
require 'net/http'

namespace :rss do
  task bbc: :environment do
    feeds = {
      'Top Stories' => 'http://feeds.bbci.co.uk/news/rss.xml',
      'World' => 'http://feeds.bbci.co.uk/news/world/rss.xml',
      'UK' => 'http://feeds.bbci.co.uk/news/uk/rss.xml',
      'Business' => 'http://feeds.bbci.co.uk/news/business/rss.xml',
      'Politics' => 'http://feeds.bbci.co.uk/news/politics/rss.xml',
      'Health' => 'http://feeds.bbci.co.uk/news/health/rss.xml',
      'Technology' => 'http://feeds.bbci.co.uk/news/technology/rss.xml',
      'Education & Family' => 'http://feeds.bbci.co.uk/news/education/rss.xml',
      'Science & Entertainment' => 'http://feeds.bbci.co.uk/news/science_and_environment/rss.xml',
      'Africa' => 'http://feeds.bbci.co.uk/news/world/africa/rss.xml',
      'Asia' => 'http://feeds.bbci.co.uk/news/world/asia/rss.xml',
      'Europe' => 'http://feeds.bbci.co.uk/news/world/europe/rss.xml',
      'Latin America' => 'http://feeds.bbci.co.uk/news/world/latin_america/rss.xml',
      'Middle East' => 'http://feeds.bbci.co.uk/news/world/middle_east/rss.xml',
      'US & Canada' => 'http://feeds.bbci.co.uk/news/world/us_and_canada/rss.xml',
      'England' => 'http://feeds.bbci.co.uk/news/england/rss.xml',
      'Northern Ireland' => 'http://feeds.bbci.co.uk/news/northern_ireland/rss.xml',
      'Scotland' => 'http://feeds.bbci.co.uk/news/scotland/rss.xml',
      'Wales' => 'http://feeds.bbci.co.uk/news/wales/rss.xml'
    }

    feeds.each do |section, url|
      bbc_articles(url, section)
    end
  end

  task :chicago_tribune do
    feeds = {
      'Breaking News' => 'http://feeds.chicagotribune.com/ChicagoBreakingNews?format=xml',
      'Chicagoland' => 'http://www.chicagotribune.com/news/local/rss2.0.xml',
      'Nation & World' => 'http://feeds.chicagotribune.com/chicagotribune/news/nationworld/',
      'Watchdog' => 'http://feeds.feedburner.com/chicagotribune/news/watchdog',
      'Elections' => 'http://www.chicagotribune.com/news/politics/localelections/rss2.0.xml',
      'Local Politics' => 'http://feeds.feedburner.com/chicagotribune/cloutstreet/',
      'Schools' => 'http://www.chicagotribune.com/news/education/rss2.0.xml',
      'National Politics' => 'http://www.chicagotribune.com/news/politicsnow/rss2.0.xml',
      'Trib Nation' => 'http://www.chicagotribune.com/news/tribnation/rss2.0.xml',
      'Business News' => 'http://feeds.feedburner.com/chicagotribune/business',
      'Breaking Business News' => 'http://feeds.feedburner.com/chicagotribune/chicagobreakingbusiness',
      'Work Life' => 'http://www.chicagotribune.com/features/life/rss2.0.xml',
      'Money' => 'http://feeds.feedburner.com/chicagotribune/yourmoney',
      'Technology' => 'http://www.chicagotribune.com/business/technology/rss2.0.xml',
      'Breaking Entertainment News' => 'http://feeds.feedburner.com/breaking_entertainment',
      'Entertainment News' => 'http://feeds.chicagotribune.com/chicagotribune/entertainment/',
      'Music' => 'http://feeds.chicagotribune.com/chicagotribune/music/',
      'Arts' => 'http://feeds.chicagotribune.com/chicagotribune/arts/',
      'Movies' => 'http://feeds.chicagotribune.com/chicagotribune/movies/',
      'Lifestyles' => 'http://www.chicagotribune.com/features/rss2.0.xml',
      'Health' => 'http://feeds.feedburner.com/chicagotribune/health',
      'Travel' => 'http://feeds.chicagotribune.com/chicagotribune/travel/',
      'Food & Dining' => 'http://feeds.chicagotribune.com/chicagotribune/dining/',
      'Life Lessons' => 'http://www.chicagotribune.com/features/life/rss2.0.xml',
      'Religion' => 'http://www.chicagotribune.com/features/life/rss2.0.xml',
      'Books' => 'http://feeds.chicagotribune.com/chicagotribune/books/'
    }

    feeds.each do |section, url|
      chicago_tribune_articles(url, section)
    end
  end
end

def bbc_articles(url, section)
  source = Source.find_by_name('BBC News')
  source ||= Source.create(name: 'BBC News', area: 'UK', 
                        url: 'http://www.bbc.co.uk/')
  feed = get_feed(url)
  feed.items.each do |item|
    puts item.pubDate

    Article.create(title: item.title, source: source, content: item.description, 
                  url: item.link, section: section)
  end
end

def chicago_tribune_articles(url, section)
  source = Source.find_by_name('Chicago Tribune')
  source ||= Source.create(name: 'Chicago Tribune', area: 'Chicago, IL, US', 
                        url: 'http://www.chicagotribune.com/')
  feed = get_feed(url)
  feed.items.each do |item|
    puts time_in_words(item.updated)

    Article.create(name: item.title, source: source, content: item.description, 
                  url: item.link, pubished_at: item.updated, section: section)
  end
end 

def get_feed(url)
  uri = URI(url)
  page = Net::HTTP.get(uri)
  RSS::Parser.parse(page)
end
