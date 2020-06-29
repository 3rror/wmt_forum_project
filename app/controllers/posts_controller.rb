class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  before_action :set_topic, only: [:create, :new]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user = current_user

    if params.include? :response_to_post
      @post.content = "<blockquote>#{Post.find(params[:response_to_post]).content}</blockquote><div><br></div>"
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    authorize @post

    if @post.save
      redirect_to @topic
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    authorize @post

    if @post.update(post_params)
      redirect_to topic_path(@post.topic), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    authorize @post

    @post.destroy
    redirect_to @post.topic, notice: 'Post was successfully deleted.'
  end

  private
    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :topic_id)
    end
end
