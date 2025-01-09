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
  { name: "東山ヒュッテ", latitude: 35.6960, longitude: 139.6990, description: "東山ヒュッテは、標高の高い位置で、快適な宿泊と食事を提供しています。夜空の星も美しいです。" }
])


