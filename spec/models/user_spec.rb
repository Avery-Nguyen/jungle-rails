require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create user if all fields are correct' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      expect(@user).to be_present
    end 

    it "should show error 'Password confirmation doesn't match Password'" do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: '123456'
      })

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should show error 'Email has already been taken' when same email is added" do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      @user1 = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'TEST@TEST.COM',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user1.save
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it "should show error 'First name can't be blank'" do
      @user = User.new({
        first_name: nil,
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "should show error 'Last name can't be blank'" do
      @user = User.new({
        first_name: "Bob",
        last_name: nil,
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should show error 'Email can't be blank'" do
      @user = User.new({
        first_name: "Bob",
        last_name: 'Rob',
        email: nil,
        password: 'code',
        password_confirmation: 'code'
      })

      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should show error 'Password is too short (minimum is 5 characters)'" do
      @user = User.new({
        first_name: "Bob",
        last_name: 'Rob',
        email: "test@test.com",
        password: 'code',
        password_confirmation: 'code'
      })

      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    
    it "should return user in with correct login info" do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      user = User.authenticate_with_credentials('test@test.com', 'code123')

      expect(user).to be_present
    end

    it "should return user in with whitespace before email" do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      user = User.authenticate_with_credentials('    test@test.com', 'code123')

      expect(user).to be_present
    end

    it "should return user in with email being case-insensitive" do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Rob',
        email: 'test@test.com',
        password: 'code123',
        password_confirmation: 'code123'
      })

      @user.save

      user = User.authenticate_with_credentials('    tESt@test.com', 'code123')

      expect(user).to be_present
    end
  end
end
