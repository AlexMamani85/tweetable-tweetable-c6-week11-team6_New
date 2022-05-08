require 'rails_helper'
describe 'Tweets', type: :request do
  describe 'index path' do
    it 'respond with http success status code' do
      get api_tweets_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns a json with all tweets' do
      user=User.create(name:"user",username:"user",email:"user@test.com",
      password:"qwerty",password_confirmation:"qwerty")
      Tweet.create(body: 'Test',user:user)
      get api_tweets_path
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq 1
    end
  end

  describe 'show path' do
    context 'with valid parameters' do
      let!(:user) { User.create(name:"user",username:"user",email:"user@test.com",
        password:"qwerty",password_confirmation:"qwerty") }
      let!(:tweet) { Tweet.create(body: 'Test',user:user) }
      before(:each) do
        get api_tweet_path(tweet)
      end
  
      it 'respond with http success status code' do
        expect(response).to have_http_status(:ok)
      end
    
      it 'respond with the correct tweet' do
        actual_tweet = JSON.parse(response.body)
        expect(actual_tweet['id']).to eql(tweet.id)
      end
    end

    context 'with invalid parameters' do
      it 'returns http status not found' do
        # params={ id: 'xxx' }
        get api_tweet_path(id: 'xxx')
        # get '/api/genres/:id', params: { id: 'xxx' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # describe 'create path' do
  #   context 'with valid parameters' do
  #     let!(:user) { User.create(name:"user",username:"user",email:"user@test.com",
  #       password:"qwerty",password_confirmation:"qwerty") }
  #     before(:each) do
  #       user_params= {name:"user",username:"user",email:"user@test.com",
  #         password:"qwerty",password_confirmation:"qwerty"} 
  #       post api_signup_path, params: user_params
  #       body = JSON.parse(response.body)
  #       p "="*50
  #       p body
  #       p "="*50
  #       # token=body["token"]
  #       # tweet_params={ tweet: {body:'test'} }
  #       # header = { Authorization:  "Token token=#{token}"}
  #       # post api_tweets_path(params,header)

  #     end

  #     it 'respond with http success status code' do
  #       expect(response).to have_http_status(:created)
  #     end

      # it 'respond with created genre' do
      #   actual_tweet = JSON.parse(response.body)
      #   expect(actual_tweet['body']).to eql('test')
      # end
    # end
    # context 'with invalid parameters' do
    #   it 'returns http status not found' do
    #     params={ genre:{title:'test'} }
    #     post api_tweets_path(params)
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end
  # end

  # describe 'update path' do
  #   context 'with valid parameters' do
  #     let!(:genre) { Genre.create(name: 'Test') }
  #     before(:each) do
  #       params={ genre:{name:'new test'} }
  #       put api_genre_path(genre,params)
  #     end

  #     it 'respond with http success status code' do
  #       expect(response).to have_http_status(:ok)
  #     end

  #     it 'respond with created genre' do
  #       actual_tweet = JSON.parse(response.body)
  #       expect(actual_tweet['name']).to eql('new test')
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     let!(:genre) { Genre.create(name: 'Test') }
  #     it 'returns http status not found' do
  #       params={ genre:{name:''} }
  #       put api_genre_path(genre,params)
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'destroy path' do
  #   let!(:genre) { Genre.create(name: 'Test') }
  #   before(:each) do
  #     delete api_genre_path(genre)
  #   end

  #   it 'respond with http success status code' do
  #     expect(response).to have_http_status(:see_other)
  #   end

  #   it 'respond with created genre' do
  #     actual_tweet = JSON.parse(response.body)
  #     p actual_tweet
  #     expect(actual_tweet).to eql({})
  #   end

  #   it 'returns size of zero' do
  #     actual_tweet = JSON.parse(response.body)
  #     expect(Genre.all.size).to eq 0
  #   end

  #   it 'deleted genre is not found' do
  #     get api_genre_path(genre)
  #     expect(response).to have_http_status(:not_found)
  #   end

  # end
end
