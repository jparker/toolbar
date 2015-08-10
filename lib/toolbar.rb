require 'toolbar/engine'

require 'forwardable'

class Toolbar
  extend Forwardable

  attr_reader :controller, :view_context, :resource

  def initialize(controller, view_context, resource, as: resource)
    @controller   = controller
    @view_context = view_context
    @resource     = resource
    @ivar         = as
  end

  delegate [:model_name] => :resource_class
  delegate [:collection, :element, :human, :i18n_key] => :model_name

  def record
    controller.instance_variable_get :"@#{ivar}"
  end

  def persisted?
    record && record.persisted?
  end

  def resource_class
    @resource.to_s.classify.constantize
  end

  def name
    human.downcase
  end

  def title
    human.titleize
  end

  def translate(key, **options)
    keys = [i18n_key, 'defaults'].flat_map do |prefix|
      ['_html', ''].map do |suffix|
        (key % { prefix: prefix, suffix: suffix }).to_sym
      end
    end
    view_context.translate keys.shift, **options, default: keys
  end

  alias_method :t, :translate

  def inspect
    '#<%s @resource=%s ivar=%s>' % [self.class, resource.inspect, ivar.inspect]
  end

  private

  attr_reader :ivar
end
