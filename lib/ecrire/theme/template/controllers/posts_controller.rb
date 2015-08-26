class PostsController < Ecrire::ThemeController
  helper_method :post, :posts

  def index
    @posts = posts.published.includes(:titles).order('published_at DESC').page(params[:page]).per(params[:per])
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.rss
      format.json do
        headers['Access-Control-Allow-Origin'] = '*'
      end
    end
  end

  def show
    redirect_to :root and return if post.nil?
    redirect_to :root and return unless post.published?
    if post.titles.first != @title
      redirect_to theme.post_path(post.year, post.month, post), status: :moved_permanently
    end

    @suggestions = Post.published.limit(5).where.not(id: post.id)
  end

  protected

  def posts
    @posts ||= Post.published.page(params[:page]).per(params[:per]).order('published_at DESC')
  end

  def post
    @title ||= Title.find_by_slug(params[:id])
    @post ||= @title.post
  end

end
