class TweetsController < ApplicationController

	before_action :find_user

	def find_user
		if (!session["user_id"].present?)
			redirect_to login_path
		end
	end
	
	def index
		if params["user_id"].present?
			@tweets = Tweet.where(user_id: params["user_id"])
		else
			@tweets = Tweet.all
		end
		@tweets.order('date desc')
	end

	def show
		@tweet = Tweet.find_by(id: params["id"])
	end

	def create
		tweet = Tweet.new
		tweet.content = params[:post_tweet]
		tweet.date = DateTime.now.to_i
		tweet.user_id = session["user_id"]
		tweet.save
		redirect_to root_path
	end

	def destroy
		Tweet.find_by(id: params["id"]).delete
		redirect_to root_path
	end

	def edit
		@tweet = Tweet.find_by(id: params["id"])
	end

	def update
		tweet = Tweet.find_by(id: params["id"])
		tweet.content = params["update_tweet"]
		tweet.image = params["image"]
		tweet.date = DateTime.now.to_i
		tweet.save
		redirect_to root_path
	end

	def personal_tweets
		@tweets = Tweet.where(user_id: params["user_id"])
		render "personal_tweets"
	end
end