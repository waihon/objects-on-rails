require 'date' # for DateTime
require 'active_model'

class Post
  # Augment Post with ActiveModel modules
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validates :title, presence: true

  attr_accessor :blog, :title, :body, :image_url, :pubdate

  def initialize(attrs = {})
    attrs.each do |k, v| send("#{k}=", v) end
  end

  def publish(clock=DateTime)
    # A sensible default for parameter injection, a type of dependency injection.
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end

  def picture?
    image_url.present?
  end
end