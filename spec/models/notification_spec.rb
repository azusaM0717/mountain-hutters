require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "アソシエーション" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notifiable) }
  end

  describe "#notification_message" do
    let(:review) { create(:review, title: "素晴らしいレビュー") }

    context "notifiableがCommentの場合" do
      let(:user) { create(:user, name: "太郎") }
      let(:comment) { create(:comment, review: review, user: user) }
      let(:notification) { create(:notification, notifiable: comment) }

      it "正しいコメント通知メッセージを返す" do
        expect(notification.notification_message).to eq(
          "投稿したレビュー「素晴らしいレビュー」に太郎さんがコメントしました。"
        )
      end
    end

    context "notifiableがFavoriteの場合" do
      let(:user) { create(:user, name: "次郎") }
      let(:favorite) { create(:favorite, review: review, user: user) }
      let(:notification) { create(:notification, notifiable: favorite) }

      it "正しいいいね通知メッセージを返す" do
        expect(notification.notification_message).to eq(
          "投稿したレビュー「素晴らしいレビュー」が次郎さんにいいねされました。"
        )
      end
    end
  end
end
