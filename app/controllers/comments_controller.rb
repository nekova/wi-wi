class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:upvote, :downvote]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(params[:post_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    # if @comment.upvotable_by?(current_user)
    if true
      @comment.upvote_by(current_user)
      User.increment_counter(:reputation, @user.id)
    else
      flash[:notice] = "You can't vote"
    end
    redirect_to @comment.post
  end

  def downvote
    # if @comment.downvotable_by?(current_user)
    if true
      @comment.downvote_by(current_user)
      User.decrement_counter(:reputation, @user.id)
    else
      flash[:notice] = "You can't vote"
    end
    redirect_to @comment.post
  end


  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user
      @user = @comment.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content).merge({post_id: params[:post_id]})
    end

    def require_permission
      if current_user != Comment.find(params[:id]).user
        redirect_to @post, notice: "You don't have permission :("
      end
    end
end
