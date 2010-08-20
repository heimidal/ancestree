require 'active_support/concern'

module Ancestree
  extend ActiveSupport::Concern
  
  def inherits_from_ancestor?(method)
    !gets_value_locally?(method)
  end

  private

  def gets_value_locally?(method)
    send("#{method}_without_parent") == send(method)
  end

  module ClassMethods
    @@inherit_ancestor_attributes = []

    def inherit_ancestor_attributes(*attrs)
      self.define_attribute_methods
      attrs.each do |attr|
        create_inheritable_method(attr)
        @@inherit_ancestor_attributes << attr.to_sym
        method_added(attr) if method_defined?(attr)
      end
    end

    def create_inheritable_method(attribute)
      name = attribute.to_s.gsub(/(\?|!)/, '')
      define_method "#{name}_with_parent#{$1}".to_sym do
        val = send("#{name}_without_parent#{$1}") || parent.try(attribute.to_sym)
        val ||= send("default_#{name}") if respond_to?("default_#{name}")
        val
      end
    end

    def method_added(name)
      if defined?(:@@inherit_ancestor_attributes) && @@inherit_ancestor_attributes.include?(name)
        @@inherit_ancestor_attributes.delete(name)
        alias_method_chain name, :parent
      end
    end

  end
end

ActiveRecord::Base.send :include, Ancestree