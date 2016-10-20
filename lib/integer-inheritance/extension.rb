# encoding: utf-8
# frozen_string_literal: true

module IntegerInheritance
  module Extension
    extend ActiveSupport::Concern

    included do
      cattr_accessor :inheritance_mapping, instance_accessor: false
      self.inheritance_mapping = {}
    end

    def as_json(options = {})
      json = super(options)
      col  = self.class.inheritance_column
      json[col] = send(col)
      json
    end

    module ClassMethods

      # http://apidock.com/rails/ActiveRecord/Inheritance/ClassMethods/sti_name
      def sti_name
        inheritance_mapping.key(super)
      end

      alias inheritance_type sti_name

      # http://apidock.com/rails/ActiveRecord/Inheritance/ClassMethods/find_sti_class
      def find_sti_class(type)
        lookup = inheritance_mapping[type.to_i]
        lookup ? super(lookup) : super
      end

    private
      # lib/active_record/inheritance.rb
      def subclass_from_attributes(attrs)
        col  = inheritance_column
        type = col.is_a?(Symbol) ? attrs[col] || attrs[col.to_s] : attrs[col] || attrs[col.to_sym]

        return if type.nil?

        return if type == inheritance_type

        subclass = inheritance_mapping[type].safe_constantize
        unless descendants.include?(subclass)
          raise ActiveRecord::SubclassNotFound, %{ Invalid single-table inheritance type:
                                                   either subclass can't be mapped to #{type}
                                                   either #{subclass} is not a subclass of #{name} }.squish
        end
        subclass
      end
    end
  end
end
