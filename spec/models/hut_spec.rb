require 'rails_helper'

RSpec.describe Hut, "モデルに関するテスト", type: :model do
  describe '保存処理のテスト' do
    it '有効な山小屋情報の場合は保存される' do
      expect(FactoryBot.build(:hut)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    context '空白のバリデーションチェック' do
      let(:hut) { FactoryBot.build(:hut) }

      it 'nameが空白の場合はエラーメッセージが返る' do
        hut.name = ''
        expect(hut).to be_invalid
        expect(hut.errors[:name]).to include("can't be blank") 
      end

      it 'descriptionが空白の場合はエラーメッセージが返る' do
        hut.description = ''
        expect(hut).to be_invalid
        expect(hut.errors[:description]).to include("can't be blank") 
      end
    end

    context '緯度経度のバリデーションチェック' do
      it 'latitudeが空白の場合はエラーメッセージが返る' do
        hut = FactoryBot.build(:hut, latitude: nil)
        expect(hut).to be_invalid
        expect(hut.errors[:latitude]).to include("can't be blank") 
      end

      it 'longitudeが空白の場合はエラーメッセージが返る' do
        hut = FactoryBot.build(:hut, longitude: nil)
        expect(hut).to be_invalid
        expect(hut.errors[:longitude]).to include("can't be blank") 
      end
    end
  end
end
