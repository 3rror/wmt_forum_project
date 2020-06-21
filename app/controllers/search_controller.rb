class SearchController < ApplicationController
  def index
    @posts = Post.pagy_search(params[:query])
    @pagy, @posts = pagy_searchkick(@posts, items: 10)
  end
end
