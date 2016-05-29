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

      alias inheritance_type sti_name

      # http://apidock.com/rails/ActiveRecord/Inheritance/ClassMethods/find_sti_class
      def find_sti_class(type)
        lookup = inheritance_mapping[type.to_i]
        lookup ? super(lookup) : super
      end

    private
      def subclass_from_attributes(attrs)
        type = attrs.with_indifferent_access[inheritance_column].to_i

        if type && type != inheritance_type
          subclass = inheritance_mapping[type].safe_constantize
          unless descendants.include?(subclass)
            raise ActiveRecord::SubclassNotFound, %{ Invalid single-table inheritance type:
                                                     either subclass can't be mapped to #{type}
                                                     either #{subclass} is not a subclass of #{name}}.trim.squish
          end
          subclass
        end
      end
    end
  end
end
