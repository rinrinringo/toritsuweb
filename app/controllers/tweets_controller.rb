class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    if params[:search] != nil && params[:search] != ''
      #部分検索かつ複数検索
      search = params[:search]
      @tweets = Tweet.joins(:user).where("gakubu LIKE ? OR gakunen LIKE ? OR gakki LIKE ? ", "%#{search}%","%#{search}%","%#{search}%")
    else
      @tweets = Tweet.all
      @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    end

    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_tweets = Tag.find_by(name: key).tweets
          @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
        end
      end
    end
  end

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end
        
  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end
        
  private
  def tweet_params
    params.require(:tweet).permit(:gakubu, :gakunen, :gakki, :memo, :image, :overall, :level, tag_ids: [])
  end
end
    
