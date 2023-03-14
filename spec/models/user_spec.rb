require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do
      @user = User.new(
        email: 'example@domain.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end

    it 'is valid with all fields set' do
      expect(@user).to be_valid
    end

    it 'is not valid without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid without a password' do
      @user.password = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password confirmation' do
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not valid with a short password' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'is not valid with a duplicate email' do
      duplicate_user = User.new(
        email: 'example@domain.com',
        first_name: 'Jane',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is valid with leading and trailing spaces in email' do
      user = User.authenticate_with_credentials(' example@domain.com ', 'password')
      expect(user).to eq(@user)
    end

    it 'is valid with email in wrong case' do
      user = User.authenticate_with_credentials('eXample@domain.COM', 'password')
      expect(user).to eq(@user)
    end
  end
end
