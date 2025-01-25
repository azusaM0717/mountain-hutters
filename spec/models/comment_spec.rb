require 'rails_helper'

RSpec.describe Comment, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効なコメントの場合は保存されるか" do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      comment = Comment.new(body: '')
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include("can't be blank")
    end
  end

  context "文字数のバリデーションチェック" do
    it "bodyが200文字を超えた場合にバリデーションエラーが返されるか" do
      comment = Comment.new(body: 'a' * 201) # 201文字
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include("is too long (maximum is 200 characters)")
    end
  end
end
