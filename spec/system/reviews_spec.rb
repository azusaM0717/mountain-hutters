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

    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content review.title
        expect(page).to have_content review.rating
        expect(page).to have_link "詳細を見る" 
      end
    end
  end

  describe "詳細画面のテスト" do
    before { visit review_path(review) }

    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link 'レビューを削除'
      end

      it '編集リンクが存在しているか' do
        expect(page).to have_link 'レビューを編集'
      end
    end

    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        click_link '編集'
        expect(current_path).to eq(edit_review_path(review))
      end
    end

    context 'レビュー削除のテスト' do
      it 'レビューを削除できるか' do
        visit review_path(review) # 再度ページを訪問
        expect { click_link '削除' }.to change { Review.count }.by(-1)
        expect(page).to have_current_path reviews_path
      end
    end
  end

  describe '編集画面のテスト' do
    before { visit edit_review_path(review) }

    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'review[title]', with: review.title
        expect(page).to have_field 'review[body]', with: review.body
      end

      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end

    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'review[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'review[body]', with: Faker::Lorem.characters(number: 30)
        click_button '保存'
        expect(page).to have_current_path review_path(review)
      end
    end
  end
end
