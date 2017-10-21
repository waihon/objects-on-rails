# Unfortunately, it's not always possible to completely eliminate type-based
# conditionals. What we can do is isolate the conditionals to a single place,
# rather than scattering them all over our view code. That's exactly what we're
# trying to do here. Anwhere we might have done an if... then... else in a
# view template based on an object's class or traits, we can instead add an
# exhibit to handle the conditional behavior polymorphically. All the
# conditionals are consolidated on this one helper method, which decides which
# exhibit(s) to apply to a given object.
module ExhibitsHelper
  def exhibit(model, context)
    # Doing a string comparison because of Rails class-reloading weirdness
    case model.class.name
    when 'Post'
      if model.picture?
        PicturePostExhibit.new(model, context)
      else
        TextPostExhibit.new(model, context)
      end
    else
      model
    end
  end
end