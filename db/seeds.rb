Tweet.destroy_all
User.destroy_all
system "rm -rf storage"

user=User.create(email: 'user@test.com', username:'user', name:'user', password:'qwerty',password_confirmation:'qwerty')
user02=User.create(email: 'user02@test.com', username:'user02', name:'user', password:'qwerty',password_confirmation:'qwerty')

tweet1=Tweet.create(body:"first tweet from user",user:user)
tweet2=Tweet.create(body:"second tweet from user02",user:user02)
tweet3=Tweet.create(body:"third tweet from user",user:user)
tweet4=Tweet.create(body:"fourth tweet from user02",user:user02)
tweet5=Tweet.create(body:"fifth tweet from user",user:user)

tweet6=Tweet.create(body:"(Response): sixth tweet",user:user02,replied_to_id:tweet1.id)
tweet7=Tweet.create(body:"(Response): seventh tweet",user:user,replied_to_id:tweet2.id)
tweet8=Tweet.create(body:"(Response): eighth tweet",user:user02,replied_to_id:tweet3.id)
tweet9=Tweet.create(body:"(Response): nineth tweet",user:user,replied_to_id:tweet4.id)
tweet10=Tweet.create(body:"(Response): tenth tweet",user:user02,replied_to_id:tweet5.id)



