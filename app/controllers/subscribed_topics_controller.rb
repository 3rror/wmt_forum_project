class SubscribedTopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @topics = pagy(current_user.subscribed_topics.includes(:topic_section, posts: [user: { avatar_attachment: :blob }]))
    render "topics/index"
  end
end
