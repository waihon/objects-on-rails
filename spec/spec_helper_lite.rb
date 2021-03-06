require 'minitest/autorun'
require 'rr'

# RR now has an autohook system. We don't need to `include RR::Adapters::*`
# in our test framework's base class anymore.
# class MiniTest::Unit::TestCase
#   include RR::Adapters::MiniTest
# end

def stub_module(full_name)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    # context will be assgined Object only on first pass. On subsequent pass
    # context will be nil.
    begin
      # Attempt to reference the given module. If the module is defined,
      # or if calling #const_get causes it to be auto-loaded, the method does
      # nothing more.
      context.const_get(name)
    rescue NameError
      # #const_get failes to turn up the module so define an anonymouis empty
      # module to act as a placeholder
      context.const_set(name, Module.new)
    end
  end
end

def stub_class(full_name)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, Class.new)
    end
  end
end