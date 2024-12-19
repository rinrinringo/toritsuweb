class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    if params[:search].present?
      # 検索ワードがある場合
      search = params[:search]
      @tweets = Tweet.where("gakubu LIKE ? OR gakunen LIKE ? OR gakki LIKE ? OR memo LIKE ?", 
      "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      @rank_tweets = @tweets.left_joins(:likes)
      .group(:id)
      .order('COUNT(likes.id) DESC')
      .limit(10)
    else
      # 検索ワードがない場合
      @rank_tweets = nil
      @tweets = Tweet.all
    end
  
    # タグ検索の処理
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
    
