class TagRelation < ActiveRecord::Base
  belongs_to :tag_1, class_name: 'Tag', foreign_key: 'tag_1_id'
  belongs_to :tag_2, class_name: 'Tag', foreign_key: 'tag_2_id'

  def self.update_relationship(tag1, tag2)
    users_subscribed_to_both = 0
    User.find_each(batch_size: 100) do |user|
      if Subscription.where(user: user, tag: tag1).count > 0 && Subscription.where(user: user, tag: tag2).count > 0
        users_subscribed_to_both += 1
      end
    end
    rel = TagRelation.find_or_init(tag1, tag2)
    rel.score = users_subscribed_to_both.to_f / tag1.subscriptions.count.to_f * tag2.subscriptions.count.to_f
    rel.save!
  end

  def self.find_or_init(tag1, tag2)
    if rel = TagRelation.where(tag_1: tag1, tag_2: tag2).first
    elsif rel = TagRelation.where(tag_1: tag2, tag_2: tag1).first
    else
      rel = TagRelation.new(tag_1: tag1, tag_2: tag2)
    end
    rel
  end
end
