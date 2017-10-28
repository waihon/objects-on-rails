require_relative '../spec_helper_full'
require_relative '../../app/models/blog'
require 'date'

describe Blog do
  include SpecHelpers
  before do
    setup_database
    @it = Blog.new
  end

  after do
    teardown_database
  end

  describe '#entries' do
    def make_entry_with_date(date)
      @it.new_post(pubdate: DateTime.parse(date), title: date)
    end

    it 'is sorted in reverse-chronological order' do
      oldest = make_entry_with_date('2017-10-09')
      newest = make_entry_with_date('2017-10-11')
      middle = make_entry_with_date('2017-10-10')

      @it.add_entry(oldest)
      @it.add_entry(newest)
      @it.add_entry(middle)

      @it.entries.must_equal([newest, middle, oldest])
    end

    it 'is limited to 10 items' do
      10.times do |i|
        @it.add_entry(make_entry_with_date("2017-10-#{i+1}"))
      end
      oldest = make_entry_with_date('2017-09-30')
      @it.add_entry(oldest)
      @it.entries.size.must_equal(10)
      @it.entries.wont_include(oldest)
    end
  end
end