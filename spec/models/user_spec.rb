# == Schema Information
#
# Table name: users
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  email                 :string(255)
#  zipcode               :integer
#  area                  :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  password_digest       :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  remember_token        :string(255)
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: 'wilhemlet jamofo', email: 'geai@lkas6df.com', 
                            password: 'foobar', password_confirmation: 'foobar', zipcode: 60201) }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

  describe 'authentication' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:invalid_user) { found_user.authenticate('invalid') }

      it { should_not eq invalid_user }
      specify { expect(invalid_user).to be_false }
    end
  end

  describe 'validation:' do
    describe 'email' do
      context 'too long' do
        before { @user.email = 'a'*100 + '@asd.com' }
        it { should_not be_valid }
      end

      context 'not present' do
        before { @user.email = ' ' }
        it { should_not be_valid }
      end

      context 'wrong format' do
        before { @user.email = 'user@hello'}
        it { should_not be_valid }
      end
    end

    describe 'name' do
      context 'not present' do
        before { @user.name = ' ' }
        it { should_not be_valid }
      end

      context 'too long' do
        before { @user.name = 'a'*51 }
        it { should_not be_valid}
      end
    end

    describe 'password' do
      context 'mismatching confirmation should not create user' do
        before { @user.password = 'different' }
        it { should_not be_valid }
      end

      context 'not present' do
        before do
          @user.password = ' '
          @user.password_confirmation = ' '
        end
        it { should_not be_valid }
      end
    end

    describe 'zipcode' do
      context 'zipcode not in range' do
        before { @user.zipcode = 1 }
        it { should_not be_valid }
      end
    end

    describe 'valid' do
      it { should be_valid }
    end
  end
end
