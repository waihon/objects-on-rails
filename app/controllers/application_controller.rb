class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_blog

private

  def init_blog
    # Make the blog instance available from the PostController by using the blog singleton object
    @blog = THE_BLOG
  end
end
