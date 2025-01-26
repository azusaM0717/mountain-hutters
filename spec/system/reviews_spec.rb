require 'rails_helper'

describe '投稿のテスト' , type: :system do
  let!(:user) { create(:user) }
  let!(:review) { create(:review, title:'hoge', body:'body') }
  
  describe 'トップ画面(root_path)のテスト' do
    before { visit root_path }

    context '表示の確認' do
      it 'トップ画面(root_path)に「Welcome to Mountain Hutters!」が表示されているか' do
        expect(page).to have_content 'Welcome to Mountain Hutters!'
      end

      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "投稿画面(new_review_path)のテスト" do
    before do
      sign_in user  # ユーザーをログインさせる
      visit new_review_path
    end

    context '表示の確認' do
      it 'new_review_pathが"/reviews/new"であるか' do
        expect(current_path).to eq('/reviews/new')
      end

      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      sign_in user  # ユーザーをログインさせる
      visit reviews_path
    end
  end
end
