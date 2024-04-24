# app/controllers/posts_controller.rb
class PostsController < ApplicationController
    def index
      @posts = Post.all
    end
  
    def show
      @post = Post.find(params[:id])
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Publicación creada exitosamente.'
      else
        render :new
      end
    end
  
    def edit
      @post = Post.find(params[:id])
    end
  
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post, notice: 'Publicación actualizada exitosamente.'
      else
        render :edit
      end
    end
  
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_url, notice: 'Publicación eliminada exitosamente.'
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :answers_count, :likes_count, :published_at)
    end
  end
  