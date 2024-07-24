# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = current_user.posts.build
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: 'Not authorized to edit this post' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
