require 'date' # for DateTime
require 'active_model'

class Post < ActiveRecord::Base
  validates :title, presence: true

  attr_accessor :blog

  def publish(clock=DateTime)
    # A sensible default for parameter injection, a type of dependency injection.
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def picture?
    image_url.present?
  end
end