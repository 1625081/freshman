class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.all
    @results = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
  def search
    results = []
    if params[:key]
      params[:key].downcase!
      keywords=params[:key].split(" ")
      Post.all.each do |p|
        for key in keywords
          if p.title.include? key
             results << p
          elsif p.tags.find_by(name: key)
             results << p
          end
        end
      end
    end
    results = Post.all if params[:key] == ""
    @results = results
    respond_to do |f|
      f.js
    end

  end

  def more
    if params[:search_ids]
      @results=[]
      #这里是为了让房间和房间描述保持一致
      if params[:search_ids].split(" ").size > 1
        @searchs=params[:search_ids].split(" ").drop(1)
        @searchs.each do |r|
          @results<<Post.find(r)
        end
      else
        @results=[]
      end

      respond_to do |f|
        f.js
      end

    end
  end

  def create
    @post = Post.new(post_params)
    names = params[:post][:tags].split(",")
    @post.tags = names_to_tags(names)

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
    names = params[:post][:tags].split(",")
    @post.tags = names_to_tags(names)

    respond_to do |format|
      if @post.update(post_params) and @post.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def names_to_tags(names)
      tags = []
      for name in names
        unless tag = Tag.find_by(name: name)
          tag = Tag.new(name: name)
          tag.save
        end
        tags << tag
      end
      return tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :answer, :replier)
    end
end