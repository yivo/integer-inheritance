module IntegerInheritance
  module Extension
    extend ActiveSupport::Concern

    included do
      cattr_accessor :inheritance_mapping, instance_accessor: false
      self.inheritance_mapping = {}
    end

    module ClassMethods

      # http://apidock.com/rails/ActiveRecord/Inheritance/ClassMethods/sti_name
      def sti_name
        v = super
        inheritance_mapping.key(v) || v
      end

      # http://apidock.com/rails/ActiveRecord/Inheritance/ClassMethods/find_sti_class
      def find_sti_class(type_name)
        lookup = inheritance_mapping[type_name.to_i]
        lookup ? super(lookup) : super
      end
    end
  end
end