require 'delegate'
require 'byebug'

# SimpleDelegator is Ruby standard library class which has a very simple job:
# forward all calls to an underlying object. Not very useful ibn and of itself;
# but a a basis for defining Decorator objects it is quite handy.
class Exhibit < SimpleDelegator
  def initialize(model, context)
    @context = context
    # Set up delegation to the model object.
    super(model)
  end

  # Together, below 2 methods will help ensure that Rails helpers such as
  # #form_for don't get confused when they encounter models wrapped in exhibits.
  def to_model
    __getobj__
  end

  def class
    __getobj__.class
  end
end