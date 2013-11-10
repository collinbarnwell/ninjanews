FactoryGirl.define do
  factory :user do
    name 'Rodrigo Manuelo'
    email 'foo@bar.com'
    password 'foobar'
    password_confirmation 'foobar'
    zipcode 60201
  end

  factory :article do
    title 'title'
    content 'content'
    url 'thebomb.com'
  end

  factory :article_read do
  end
end
