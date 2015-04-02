class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_user, only: [:upvote, :downvote]
  skip_before_action :require_login, only: [:index, :show]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    sort = case params[:sort]
    when "new"
      "created_at DESC"
    when "hot"
      "updated_at DESC"
    when "best"
      "cached_votes_score DESC"
    else
      "updated_at DESC"
    end
    @posts = Post.order(sort)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.includes(:user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    if @post.upvotable_by?(current_user)
      @post.upvote_by(current_user)
      User.increment_counter(:reputation, @user.id)
    else
      flash[:notice] = "You can't vote"
    end
    redirect_to @post
  end

  def downvote
    if @post.downvotable_by?(current_user)
      @post.downvote_by(current_user)
      User.decrement_counter(:reputation, @user.id)
    else
      flash[:notice] = "You can't vote"
    end
    redirect_to @post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = @post.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content)
    end

    def require_permission
      if current_user != @post.user
        redirect_to @post, notice: "You don't have permission :("
      end
    end
end
