document.addEventListener("DOMContentLoaded", function() {
  const searchTypeSelect = document.getElementById('search_type_select'); // 検索タイプセレクト
  const dateFields = document.getElementById('date-fields'); // 日付フィールド
  const sortSelect = document.getElementById('sort_select'); // 並び順セレクト

  // searchTypeSelect、dateFields、sortSelectが存在しない場合は処理を終了
  if (!searchTypeSelect || !dateFields || !sortSelect) return;

  // 日付フィールドの表示/非表示を切り替える関数
  function toggleDateFields() {
    if (searchTypeSelect.value === 'reviews') {
      dateFields.style.display = 'flex'; // 表示
    } else {
      dateFields.style.display = 'none'; // 非表示
    }
  }

  // 並び順セレクトのオプションを切り替える関数
  function updateSortOptions() {
    if (searchTypeSelect.value === 'huts') {
      // 山小屋検索の場合
      sortSelect.innerHTML = `
        <option value="rating_desc">評価の高い順</option>
        <option value="review_count_desc">レビュー数の多い順</option>
      `;
    } else if (searchTypeSelect.value === 'reviews') {
      // レビュー検索の場合
      sortSelect.innerHTML = `
        <option value="newest">新しい投稿順</option>
        <option value="like_count_desc">いいねの多い順</option>
      `;
    }
  }

  // ページ読み込み時に初期状態を設定
  toggleDateFields();
  updateSortOptions();

  // 検索タイプが変更されたときに日付フィールドと並び順を更新
  searchTypeSelect.addEventListener('change', function() {
    toggleDateFields();
    updateSortOptions();
  });
});
