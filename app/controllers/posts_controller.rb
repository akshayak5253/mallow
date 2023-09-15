# Post Controller
class PostsController < ApplicationController
  before_action :set_topic, except: [:all_posts]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts
    return unless params[:search]
    @posts = Post.where("title LIKE ?", "%#{params[:search]}%")
  end
  def all_posts
    @posts = Post.page(params[:page]).per(10)
  end



  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build
    @post.tag_ids = []
  end

  def create
    @post = @topic.posts.build(post_params)
    if @post.save
      redirect_to topic_posts_path(@topic), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to topic_posts_path(@topic), notice: 'Post was successfully destroyed.'
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :writer, tag_ids: [])
  end
end
