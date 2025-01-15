#管理者初期データ
admin_email = "admin@admin"
admin_password = "password"

Admin.find_or_create_by!(email: admin_email) do |admin|
  admin.password = admin_password
  admin.password_confirmation = admin_password
end

#山小屋初期データ
Hut.create!([
  { name: "西山山荘", latitude: 35.6895, longitude: 139.6917, description: "西山山荘は、静かな山頂に位置し、登山者に休息を提供する場所です。素晴らしい景色を楽しみながら、心地よい時間を過ごせます。" },
  { name: "東山山荘" , latitude: 35.6897, longitude: 139.6920, description: "東山山荘は東山の頂に建つ歴史ある山小屋で、周囲の自然を満喫しながらゆっくりと過ごせる場所です。"},
  { name: "北山五合目山荘", latitude: 35.6900, longitude: 139.6930, description: "北山五合目山荘は、標高が高く、登山の途中での休憩場所として最適です。絶景が広がります。" },
  { name: "南山八合目山荘", latitude: 35.6910, longitude: 139.6940, description: "南山八合目山荘では、標高の高い位置での素晴らしい日の出と日の入りを堪能できます。" },
  { name: "南山小屋", latitude: 35.6920, longitude: 139.6950, description: "南山小屋は静かな場所に立地し、登山者にとって心地よい宿泊場所です。自然に囲まれてリラックスできます。" },
  { name: "北山小屋", latitude: 35.6920, longitude: 139.6950, description: "北山小屋は、北山の登山道沿いにあり、登山者に休息と温かい食事を提供します。" },
  { name: "西山ヒュッテ", latitude: 35.6940, longitude: 139.6970, description: "西山ヒュッテは、山頂に近い位置にあり、素晴らしい眺望と静かな環境を提供します。" },
  { name: "北山ヒュッテ", latitude: 35.6950, longitude: 139.6980, description: "北山ヒュッテでは、登山の途中で疲れた体を癒し、食事や温かい飲み物でリフレッシュできます。" },
  { name: "東山ヒュッテ", latitude: 35.6960, longitude: 139.6990, description: "東山ヒュッテは、標高の高い位置で、快適な宿泊と食事を提供しています。夜空の星も美しいです。" },
  { name: "北高山小屋", latitude: 35.7000, longitude: 139.7010, description: "北高山小屋は、山の北側にあり、登山者にとって絶好の休息スポットです。" },
  { name: "中央山小屋", latitude: 35.7010, longitude: 139.7020, description: "中央山小屋は、山の中心にあり、遠くの山々の美しい景色を楽しむことができます。" },
  { name: "大東山山荘", latitude: 35.7020, longitude: 139.7030, description: "大東山山荘では、標高の高い位置からの景色が見事で、静かな時間を過ごせます。" },
  { name: "小川山小屋", latitude: 35.7030, longitude: 139.7040, description: "小川山小屋は、登山の途中で休憩できる快適な場所で、周囲の自然も魅力です。" },
  { name: "高原山荘", latitude: 35.7040, longitude: 139.7050, description: "高原山荘は、広大な高原に位置し、登山者にとって大自然に包まれたリラックスできる場所です。" }
])

#サンプルユーザー
users = User.create!([
  { name: "ユーザー1", email: "user1@mail", password: "password" , is_active: "true" },
  { name: "ユーザー2", email: "user2@mail", password: "password" , is_active: "true" },
  { name: "ユーザー3", email: "user3@mail", password: "password" , is_active: "true" },
  { name: "ユーザー4", email: "user4@mail", password: "password" , is_active: "true" },
  { name: "ユーザー5", email: "user5@mail", password: "password" , is_active: "true" },
  { name: "ユーザー6", email: "user6@mail", password: "password" , is_active: "true" },
  { name: "ユーザー7", email: "user7@mail", password: "password" , is_active: "true" },
  { name: "ユーザー8", email: "user8@mail", password: "password" , is_active: "true" },
  { name: "ユーザー9", email: "user9@mail", password: "password" , is_active: "true" },
  { name: "ユーザー10", email: "user10@mail", password: "password" , is_active: "true" },
  { name: "ユーザー11", email: "user11@mail", password: "password" , is_active: "true" },
  { name: "ユーザー12", email: "user12@mail", password: "password" , is_active: "true" }
])

# サンプルレビュー
reviews = Review.create!([
  { title: "素晴らしい山小屋", body: "とても静かで景色が美しかったです。また行きたいです。", rating: 5, hut_id: 1, user_id: 1 },
  { title: "快適な宿泊", body: "休憩に最適で、食事も美味しかったです。", rating: 4, hut_id: 1, user_id: 2 },
  { title: "また訪れたい", body: "登山の途中での休憩には最高でした。", rating: 4, hut_id: 2, user_id: 3 },
  { title: "絶景！", body: "山頂の景色が最高でした。", rating: 5, hut_id: 5, user_id: 4 },
  { title: "心地よい空間", body: "静かで落ち着いた雰囲気の山小屋でした。", rating: 5, hut_id: 6, user_id: 4 },
  { title: "素晴らしい場所", body: "日の出がとても美しく、感動しました。", rating: 5, hut_id: 8, user_id: 1 },
  { title: "とても良かった", body: "登山途中に立ち寄りましたが、リフレッシュできました。", rating: 4, hut_id: 8, user_id: 4 },
  { title: "また行きたい", body: "快適な宿泊ができました。", rating: 4, hut_id: 11, user_id: 3 },
  { title: "最高の体験", body: "食事も美味しく、スタッフも親切でした。", rating: 5, hut_id: 11, user_id: 5 },
  { title: "ゆったりと過ごせた", body: "素晴らしい場所で、リラックスできました。", rating: 4, hut_id: 9, user_id: 9 }
])

