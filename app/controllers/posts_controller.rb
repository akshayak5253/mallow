# Post Controller
class PostsController < ApplicationController
  before_action :set_topic, except: [:all_posts]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts
    return unless params[:search]
    @posts = Post.where("title LIKE ?", "%#{params[:search]}%")
  end
  def all_posts
    @posts = Post.page(params[:page]).per(10)
  end
  def mark_as_read
    @post = Post.find(params[:id])
    current_user.read_posts << @post
    head :ok
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build
    @post.tag_ids = []
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    @post.image.attach(params[:post][:image]) if params[:post][:image]

    if @post.save
      redirect_to topic_posts_path(@topic), notice: 'Post was successfully created.'

    else
      render :new
    end
  end

  def show
    @ability = Ability.new(current_user)
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.find(params[:id])
    @count = @posts.comments.count
    if user_signed_in? && !@post.marked_as_read?(current_user)
      # Mark the post as read
      @post.mark_as_read(current_user)
    end
  end

  def edit
    authorize! :update, @post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end


  def update
    authorize! :update, @post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    if @post.update(post_params)
      @post.image.attach(params[:post][:image]) if params[:post][:image]
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @post
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
