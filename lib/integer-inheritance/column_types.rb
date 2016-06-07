# frozen_string_literal: true
module IntegerInheritance
  module ColumnTypes
    def inheritance_column(*args)
      options      = { null: false, index: true, limit: 1, default: 1 }.merge!(args.extract_options!)
      column_names = args.presence || [IntegerInheritance.default_column]
      column_names.each { |name| column(name, :integer, options) }
    end
  end
end
