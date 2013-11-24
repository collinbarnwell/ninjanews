require 'rss'
require 'net/http'

namespace :rss do
  task get_new_articles: :environment do
    new_articles_count = 0
    Feed.find_each(batch_size: 100) do |f|
      feed = get_feed(f.url)
      feed.items.each do |item|
        break unless Article.create(title: item.title, feed_id: f.id,
                                    content: item.description,
                                    url: item.link, created_at: item.pubDate)
        new_articles_count += 1
      end
    end
    puts "#{new_articles_count} new articles created."
  end
end

def get_feed(url)
  uri = URI(url)
  page = Net::HTTP.get(uri)
  RSS::Parser.parse(page)
end
