require 'delegate'

# SimpleDelegator is Ruby standard library class which has a very simple job:
# forward all calls to an underlying object. Not very useful ibn and of itself;
# but a a basis for defining Decorator objects it is quite handy.
class PicturePostExhibit < SimpleDelegator
  def initialize(model, context)
    @context = context
    # Set up delegation to the model object.
    super(model)
  end

  def render_body
    @context.render(partial: '/posts/picture_body', locals: { post: self })
  end
end