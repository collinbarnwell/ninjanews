# == Schema Information
#
# Table name: articles
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  image      :string(255)
#  content    :string(255)
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  source_id  :integer
#  feed_id    :integer
#

require 'spec_helper'

describe Article do
  describe '#read_by' do
    before do
      @user = create :user
      @article = create :article
    end

    context 'with a read article' do
      it 'should return that article' do
        create :article_read, article: @article, user: @user
        Article.read_by(@user).first.should == @article
      end
    end

    context 'with an article that has not been read' do
      it 'should return no articles' do
        Article.read_by(@user).first.should_not == @article
      end
    end
  end

  describe '#not_read_by' do
    before do
      @user = create :user
      @article = create :article
    end

    context 'with no read articles' do
      it 'should return article' do
        Article.not_read_by(@user).first.should == @article
      end
    end

    context 'with a read article' do
      it 'should return no articles' do
        create :article_read, article: @article, user: @user
        Article.not_read_by(@user).first.should_not == @article
      end
    end
  end
end
