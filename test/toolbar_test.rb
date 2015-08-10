require 'test_helper'
require 'minitest/mock'

class Thing
  extend ActiveModel::Naming
end

describe Toolbar do
  let(:stub_controller) { StubController.new }
  let(:stub_view)       { StubView.new }
  let(:toolbar)         { Toolbar.new stub_controller, stub_view, :thing }

  it 'determines resource class from resource' do
    _(toolbar.resource_class).must_equal Thing
  end

  it 'delegates #collection to resource_class.model_name' do
    _(toolbar.collection).must_equal 'things'
  end

  it 'delegates #element to resource_class.model_name' do
    _(toolbar.element).must_equal 'thing'
  end

  it 'returns lowercase human name for #name' do
    _(toolbar.name).must_equal 'thing'
  end

  it 'returns titleized human name for #title' do
    _(toolbar.title).must_equal 'Thing'
  end

  it 'returns instance variable for resource for #record' do
    thing      = Thing.new
    controller = StubController.new thing: thing
    toolbar    = Toolbar.new controller, stub_view, :thing

    _(toolbar.record).must_be_same_as thing
  end

  it 'uses alias to look up instance variable name' do
    thing      = Thing.new
    controller = StubController.new nickname: thing
    toolbar    = Toolbar.new controller, stub_view, :thing, as: :nickname

    _(toolbar.record).must_be_same_as thing
  end

  it 'is not persisted if instance variable is undefined' do
    _(toolbar).wont_be :persisted?
  end

  it 'delegates #persisted? to instance variable' do
    thing      = Thing.new
    controller = StubController.new thing: thing
    toolbar    = Toolbar.new controller, stub_view, :thing

    def thing.persisted? ; false ; end
    _(toolbar).wont_be :persisted?

    def thing.persisted? ; true ; end
    _(toolbar).must_be :persisted?
  end

  it 'delegates #translate to view_context with fallback i18n keys' do
    main      = :'thing.action_html'
    fallbacks = %i[thing.action defaults.action_html defaults.action]
    view      = Minitest::Mock.new
    view.expect :translate, 'translation', [main, { default: fallbacks }]

    toolbar = Toolbar.new stub_controller, view, :thing
    toolbar.translate '%{prefix}.action%{suffix}'

    view.verify
  end

  class StubController
    def initialize(**ivars)
      ivars.each do |name, value|
        instance_variable_set :"@#{name}", value
      end
    end
  end

  class StubView
  end
end
