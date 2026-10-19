class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content].to_s.strip

    if @model == "user"
      @records = User.search_for(@content)
    elsif @model == "tag"
      @records = Post.joins(:tags).where("tags.name LIKE ?", "%#{@content}%").distinct
    else
      @records = Post.search_for(@content)
    end
  end
end
