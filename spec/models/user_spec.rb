require 'rails_helper'

RSpec.describe User, type: :model do
    before do
        @user = build(:user)
    end
    
    it '有効なファクトリを持つこと' do
        expect(build(:user)).to be_valid
    end
    
    it '名前、メール、パスワードがある場合、有効であること' do
        user = User.new(
            name: 'TestUser',
            email: 'test@expample.com',
            password: 'password'
        )
        expect(user).to be_valid
    end
    
    describe '存在性の検証' do
        it '名前がない場合、無効であること' do
            @user.name = ' '
            expect(@user.valid?).to eq(false)
        end
    
        it 'メールアドレスがない場合、無効であること' do
            @user.email = ' '
            expect(@user.valid?).to eq(false)
        end
    
        it 'パスワードがない場合、無効であること' do
            @user.password = @user.password_confirmation = ' ' * 8
            expect(@user.valid?).to eq(false)
        end
    end

    describe '文字数の検証' do
        it '名前が10文字以内の場合、有効であること' do
            @user.name = 'a' * 10
            expect(@user.valid?).to eq(true)
        end

        it '名前が11文字以上の場合、無効であること' do
            @user.name = 'a' * 11
            expect(@user.valid?).to eq(false)
        end

        it 'メールアドレスが255文字以内の場合、有効であること' do
            @user.email = 'a' * 243 + '@example.com'
            expect(@user.valid?).to eq(true)
        end

        it 'メールアドレスが256文字以上の場合、無効であること' do
            @user.email = 'a' * 244 + '@example.com'
            expect(@user.valid?).to eq(false)
        end

        it 'パスワードが8文字以上の場合、有効であること' do
            @user.password = 'a' * 8
            expect(@user.valid?).to eq(true)
        end

        it 'パスワードが7文字以下の場合、無効であること' do
            @user.password = 'a' * 7
            expect(@user.valid?).to eq(false)
        end
    end

    describe '一意性の検証' do
        it 'メールアドレスが小文字化されていること' do
            @user.email = "TEST@EXAMPLE.COM"
            @user.save
            expect(@user.email).to eq("test@example.com")
        end

        it '重複したメールアドレスの場合、無効であること' do
            user1 = create(:user, name: 'taro', email: 'taro@example.com')
            user2 = build(:user, name: 'jiro', email: user1.email)
            expect(user2.valid?).to eq(false)
        end
    end

    describe 'パスワードの検証' do
        it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
        end
    end
end