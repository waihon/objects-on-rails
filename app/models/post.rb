require 'date' # for DateTime

class Post
  # Augment Post with ActiveModel modules
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :blog, :title, :body, :pubdate

  def initialize(attrs = {})
    attrs.each do |k, v| send("#{k}=", v) end
  end

  def publish(clock=DateTime)
    # A sensible default for parameter injection, a type of dependency injection.
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end