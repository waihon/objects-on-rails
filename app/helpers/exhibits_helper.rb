module ExhibitsHelper
  def exhibit(model, context)
    # Delegate to a a class method on the Exhibit base class.
    Exhibit.exhibit(model, context)
   end
end