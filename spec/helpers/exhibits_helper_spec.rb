require_relative '../spec_helper_lite'
require_relative '../../app/helpers/exhibits_helper'

# stub_class returns Class.new which caused this particular test to fail.
# stub_class 'PicturePostExhibit'
# stub_class 'TextPostExhibit'
# stub_class 'Post'
require_relative '../../app/exhibits/picture_post_exhibit'
require_relative '../../app/exhibits/text_post_exhibit'
require_relative '../../app/models/post'

describe ExhibitsHelper do
  before do
    @it = Object.new
    @it.extend ExhibitsHelper
    @context = stub!
  end

  it 'decorates picture posts with a PicturePostExhibit' do
    post = Post.new
    stub(post).picture? { true }
    # Both must_be_kind_of and must_be_instance_of expects Post instead of PicturePostExhibit
    @it.exhibit(post, @context).class.must_equal(PicturePostExhibit)
  end

  it 'decorates text posts with a TextPostExhibit' do
    post = Post.new
    stub(post).picture?{ false }
    # Both must_be_kind_of and must_be_instance_of expects Post instead of TextPostExhibit
    @it.exhibit(post, @context).class.must_equal(TextPostExhibit)
  end

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    @it.exhibit(model, @context).must_be_same_as(model)
  end
end