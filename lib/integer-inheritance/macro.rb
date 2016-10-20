# encoding: utf-8
# frozen_string_literal: true

module IntegerInheritance
  module Macro
    extend ActiveSupport::Concern

    module ClassMethods
      def uses_integer_inheritance(options = {})
        include IntegerInheritance::Extension unless respond_to?(:inheritance_mapping)

        self.inheritance_column = options.fetch(:column, IntegerInheritance.default_column)

        # This is workaround for ActionDispatch::Reloader (in development environment)
        class_name = name
        mapping    = IntegerInheritance.mappings[class_name]
        self.inheritance_mapping = mapping if mapping
        IntegerInheritance.mappings[class_name] = self.inheritance_mapping
      end
    end
  end
end
