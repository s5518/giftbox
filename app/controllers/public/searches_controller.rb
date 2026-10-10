class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model] == "user" ? "user" : "post"
    @content = params[:content].to_s.strip

    if @model == 'user'
      @records = User.search_for(@content)
    else
      @records = Post.search_for(@content)
    end
  end
end
