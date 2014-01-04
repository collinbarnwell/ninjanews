require 'rss'
require 'net/http'
require 'calais'
require 'image_scraper'

namespace :rss do
  task get_new_articles: :environment do
    new_articles_count = 0
    Feed.find_each(batch_size: 100) do |f|
      feed = get_feed(f.url)
      feed.items.each do |item|
        begin
          break unless a = Article.create(title: item.title, feed_id: f.id,
                                          content: item.description,
                                          url: item.link, created_at: item.pubDate)
          new_articles_count += 1

          ImageScraper.get_image(a)

          Calais.get_tags(a).each do |tag|
            t = Tag.find_or_initialize_by(title: tag)
            t.articles << a
            t.save!
          end
        rescue
        end
      end
    end
    puts "#{new_articles_count} new articles created."
  end

  task redo_tags: :environment do
    new_tags_count = 0
    article_num = 0
    Article.find_each(batch_size: 100) do |a|
      Calais.get_tags(a).each do |tag|
        t = Tag.find_or_initialize_by(title: tag)
        unless t.articles.include? a
          t.articles << a
          new_tags_count += 1
          t.save!
        end
      end
      sleep 1 if (article_num + 1) % 4 == 0
      article_num += 1
    end
    puts "#{new_tags_count} tags added."
  end
end

def get_feed(url)
  uri = URI(url)
  page = Net::HTTP.get(uri)
  RSS::Parser.parse(page)
end
