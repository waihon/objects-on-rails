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

  def self.exhibit(object, context)
    # Iterate through a list of pre-defined exhibits, giving each one an
    # opportunity to wrap the provided object.
    # It strongly resembles but differs from the traditional version of Chain
    # of Responsibility pattern in that it doesn't return as soon as the first
    # exhibit capable of wrapping the object is found.
    exhibits.inject(object) do |object, exhibit|
      exhibit.exhibit_if_applicable(object, context)
    end
  end

  # An example of "Tell, Don't Ask". This keeps the .exhibit logic nicely focused
  # on one and only one thing: giving each exhibit an opportunity to apply itself
  # to the object at hand.
  def self.exhibit_if_applicable(object, context)
    if applicable_to?(object)
      new(object, context)
    else
      object
    end
  end

  def self.applicable_to?(object)
    # Subclasses will have to implement it to match applicable objects.
    false
  end

  def self.exhibits
    # The advantage of hard-coding this list is that it ensures a consistent and
    # obvious ordering of exhibits. We know which exhibits may be applied, and
    # we know the order in which they will be tried.
    [
      TextPostExhibit,
      PicturePostExhibit,
      LinkExhibit
    ]
  end
end