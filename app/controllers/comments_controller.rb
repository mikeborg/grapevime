class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end
  
  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end
    
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end
  
  # POST /comments
  # POST /comment.json
  def create
    @comment = Comment.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /comments/1/edit
    def edit
    end

    # POST /comments
    # POST /comments.json
    def create
      #comment_params[:content] = comment_params[:content].to_json
      @comment = Comment.new(comment_params)
      

      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          format.json { render json: @comment, status: :created, location: @comment }
        else
          format.html { render action: "new" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /comments/1
    # PATCH/PUT /comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to comments_url }
        format.json { head :no_content }
      end
    end
  
  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
    
    def comment_params
      params.require(:comment).permit(:content)
    end
end