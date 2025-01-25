# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, "モデルに関するテスト", type: :model do
  describe '保存処理のテスト' do
    it '有効な投稿内容の場合は保存される' do
      expect(FactoryBot.build(:review)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    context '空白のバリデーションチェック' do
      let(:review) { FactoryBot.build(:review) } # 共通のFactoryBotデータを使用

      it 'titleが空白の場合はエラーメッセージが返る' do
        review.title = ''
        expect(review).to be_invalid
        expect(review.errors[:title]).to include("can't be blank") 
      end

      it 'bodyが空白の場合はエラーメッセージが返る' do
        review.body = ''
        expect(review).to be_invalid
        expect(review.errors[:body]).to include("can't be blank") 
      end

      it 'ratingが空白の場合はエラーメッセージが返る' do
        review.rating = nil
        expect(review).to be_invalid
        expect(review.errors[:rating]).to include("can't be blank") 
      end
    end
  end
end
