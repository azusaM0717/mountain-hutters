require 'rails_helper'

RSpec.describe Favorite, "モデルに関するテスト", type: :model do
  describe "アソシエーション" do
    it { should belong_to(:user) }
    it { should belong_to(:review) }
    it { should have_one(:notification).dependent(:destroy) }
  end

  describe "コールバック(通知生成)" do
    let(:user) { create(:user) }
    let(:review) { create(:review, user: user) }
    
    it "お気に入り作成時に通知が生成されること" do
      favorite = Favorite.create(user: create(:user), review: review)
      expect(favorite.notification).not_to be_nil
      expect(favorite.notification.user_id).to eq(user.id)
      expect(favorite.notification.notifiable).to eq(favorite)
    end
  end
end
