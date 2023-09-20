# Comments Controller
class CommentsController < ApplicationController
  def index
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to topic_post_comments_path(@topic, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
