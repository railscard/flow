# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'dev.yuriy.a@gmail.com', password: 'password')

(1..10).each do |i|
  Stream.create(user_id: user.id, name: "Process #{i}", code: 'hello world')
  Download.create(user_id: user.id, name: "Download #{i}")
end

Download.all.each_with_index do |download, i|
  Input.create(download_id: i+1, line: i+1, content: 'content')
  Output.create(download_id: i+1, stream_id: i+1, line: i+1, content: 'content', responce: 'success')
end
