class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: [ :edit, :update, :destroy ]

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグを登録しました"
    else
      @tags = Tag.all
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, notice: "タグを削除しました"
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :category)
  end
end
