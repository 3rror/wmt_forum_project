class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  def index
    @topics = Topic.includes(:topic_section, posts: [user: { avatar_attachment: :blob }]).all
    @pagy, @topics = pagy(@topics)
  end

  # GET /topics/1
  def show
    @posts = @topic.posts.includes([:rich_text_content, user: { avatar_attachment: :blob }])
    @pagy, @posts = pagy(@posts)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @post = @topic.posts.build
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)
    @topic.posts.first.user = current_user
    @topic.subscribed_users << current_user

    if @topic.save
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  def update
    authorize @topic

    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topics/1
  def destroy
    authorize @topic

    @topic.destroy

    redirect_to topics_url, notice: 'Topic was successfully destroyed.'
  end

  def subscribe
    @topic = Topic.find(params[:topic_id])
    current_user.subscribed_topics << @topic

    redirect_to @topic, notice: 'You are now following this topic.'
  end

  def unsubscribe
    @topic = Topic.find(params[:topic_id])
    current_user.subscribed_topics.destroy(@topic)

    redirect_to @topic, notice: 'You are not following anymore this topic.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      # @topic = Topic.includes(posts: { user: { avatar_attachment: :blob } } ).find(params[:id])
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :topic_section_id, posts_attributes: [:id, :content])
    end
end
