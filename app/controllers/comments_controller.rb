# Comments Controller
class CommentsController < ApplicationController
  # load_and_authorize_resource
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
    @comment.user = current_user
    if @comment.save
      redirect_to topic_post_comments_path(@topic, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    # authorize! :edit, @comment # Authorize the user to edit this comment
  end
  def rate
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = Comment.find(params[:id])
    rating = params[:rating].to_i

    # Assuming 'rating' is an attribute of the Comment model
    @comment.rating = rating

    if @comment.save
      redirect_to topic_post_comments_path(@topic, @post), notice: 'Ratinf was successfully created.'
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to save rating for the comment.')
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    # authorize! :update, @comment # Authorize the user to update this comment

    if @comment.update(comment_params)
      redirect_to topic_post_path(@topic, @post), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
