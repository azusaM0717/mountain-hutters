require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '保存処理のテスト' do
    it '有効なユーザー情報の場合は保存される' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    context '空白のバリデーションチェック' do
      let(:user) { FactoryBot.build(:user) }

      it 'nameが空白の場合はエラーメッセージが返る' do
        user.name = ''
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("can't be blank") 
      end

      it 'emailが空白の場合はエラーメッセージが返る' do
        user.email = ''
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("can't be blank") 
      end

      it 'passwordが空白の場合はエラーメッセージが返る' do
        user.password = ''
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("can't be blank") 
      end
    end

    context 'emailのフォーマットチェック' do
      it '無効なemailの場合はエラーメッセージが返る' do
        invalid_email_user = FactoryBot.build(:user, email: 'invalid_email')
        expect(invalid_email_user).to be_invalid
        expect(invalid_email_user.errors[:email]).to include("is invalid") 
      end
    end
  end
end
