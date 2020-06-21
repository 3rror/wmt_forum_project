class TopicSectionsController < ApplicationController
  def show
    @topic_section = TopicSection.find(params[:id])
    @pagy, @topics = pagy(@topic_section.topics.includes([:topic_section]))

    render "topics/index"
  end
end
