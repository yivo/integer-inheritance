module IntegerInheritance
  module Macro
    extend ActiveSupport::Concern

    module ClassMethods
      def uses_integer_inheritance
        include IntegerInheritance::Extension unless respond_to?(:inheritance_mapping)

        mapping = IntegerInheritance.mappings[name]
        self.inheritance_mapping = mapping if mapping
        IntegerInheritance.mappings[name] = self.inheritance_mapping
      end
    end
  end
end