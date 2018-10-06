class BlogsController < ApplicationController
  before_action :set_user_blog, only: [:show, :edit, :update, :destroy]
  before_action :set_blog, only: [:posts]
  before_action :authenticate_user!, except: [:index, :posts, :post_details]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  def posts
    if params[:q_post].present?
      @posts = post_search(@blog, params[:q_post])
    else
      @posts = @blog.posts.published
    end
  end

  def post_details
    @post = Post.friendly.find(params[:post_id])
    commontator_thread_show(@post)
  end

  def manage
    @blogs = Blog.where(user_id: current_user.id)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Search posts by title, body and tags
    def post_search(blog, term)
      blog.posts.search(term, blog.id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user_blog
      @blog = Blog.by_user(current_user.id).by_friendly_id(params[:id])
    end

    def set_blog
      @blog = Blog.by_friendly_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :desc)
    end
end
