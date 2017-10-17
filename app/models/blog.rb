class Blog
  # Use setter injection to startegize how Blog objects create new entries.
  attr_writer :post_source

  def initialize
    @entries = []
  end

  def title
    'Watching Paint Dry'
  end

  def subtitle
    'The trusted source for drying paint news & opinion'
  end

  def new_post(*args)
    # Blog#new_post depends only on "some callable which will return a post when called".
    # We explicitly hold off from binding Blog to the Post class interface.
    post_source.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    @entries << entry
  end

  def entries
    @entries.sort_by{ |e| e.pubdate }.reverse.take(10)
  end

private

  # This is actually a factory, as in "the Factory pattern"
  def post_source
    # A sensible default for setter injection, which is a type of dependency injection.
    @post_source ||= Post.public_method(:new)
  end
end