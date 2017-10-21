class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_blog
  # Because we'll probably be using #exhibit helper method all over the place in the future.
  # Below represents app/helpers/exhibits_helper.rb
  helper :exhibits

private

  def init_blog
    # Make the blog instance available from the PostController by using the blog singleton object
    @blog = THE_BLOG
  end
end
