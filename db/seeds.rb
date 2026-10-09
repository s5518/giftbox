
# GiftBox サンプルデータ
# 架空のユーザーとレビューを登録する

seed_password = ENV.fetch("SEED_USER_PASSWORD")

# サンプルユーザー
sakura = User.find_or_create_by!(email: "sakura@example.com") do |user|
  user.name = "さくら"
  user.password = seed_password
  user.introduction = "プレゼントを選ぶのが好きです！"
end

haruka = User.find_or_create_by!(email: "haruka@example.com") do |user|
  user.name = "はるか"
  user.password = seed_password
  user.introduction = "もらって嬉しかった贈り物を紹介します。"
end

# サンプルレビュー
sample_posts = [
  {
    user: sakura,
    gift_name: "ハンドクリーム",
    content: "友人から誕生日にもらいました。香りがよく、毎日使えて嬉しかったです。",
    rating: 5,
    age: 28,
    price: 2500
  },
  {
    user: haruka,
    gift_name: "ワイヤレスイヤホン",
    content: "恋人への誕生日プレゼントに選びました。通勤中にも使えると喜んでもらえました。",
    rating: 5,
    age: 27,
    price: 12000
  },
  {
    user: sakura,
    gift_name: "タンブラー",
    content: "職場の同僚への送別品として贈りました。デザインがシンプルで使いやすいと好評でした。",
    rating: 4,
    age: 30,
    price: 3500
  },
  {
    user: haruka,
    gift_name: "入浴剤ギフトセット",
    content: "家族からもらったプレゼントです。いろいろな香りを楽しめて、リラックスできました。",
    rating: 5,
    age: 25,
    price: 3000
  },
  {
    user: sakura,
    gift_name: "マグカップ",
    content: "友人への引っ越し祝いに贈りました。落ち着いた色合いで気に入ってもらえました。",
    rating: 4,
    age: 29,
    price: 2000
  }
]

sample_posts.each do |data|
  user = data.fetch(:user)
  Post.find_or_create_by!(
    user: user,
    gift_name: data.fetch(:gift_name)
  ) do |post|
    post.content = data.fetch(:content)
    post.rating = data.fetch(:rating)
    post.age = data.fetch(:age)
    post.price = data.fetch(:price)
  end
end

puts "GiftBoxのサンプルデータを登録しました！"

