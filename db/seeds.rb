Tweet.destroy_all
User.destroy_all

user=User.create(email: 'user@test.com', username:'user', name:'user', password:'qwerty',password_confirmation:'qwerty')
user02=User.create(email: 'user02@test.com', username:'user02', name:'user', password:'qwerty',password_confirmation:'qwerty')

Tweet.create(body:"first tweet",user:user)