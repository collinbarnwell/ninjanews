require 'spec_helper'

describe 'basic pages' do
  subject { page }

  describe 'sessions#signin => users#show' do
    it do
      user = create :user
      visit signin_path
      should have_content 'Sign in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      current_path.should == user_path(user)
    end
  end

  describe 'sessions#signup => users#show' do
    it do
      visit signup_path
      should have_content 'NINJA'
      user = build :user
      fill_in 'Name', with: user.name
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'Zipcode', with: user.zipcode
      fill_in 'user_password_confirmation', with: user.password
      click_button 'Create'
      should have_content user.name
    end
  end
end