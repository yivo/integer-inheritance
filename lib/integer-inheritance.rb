require 'active_support/all'
require 'active_record'

require 'integer-inheritance/macro'
require 'integer-inheritance/extension'
require 'integer-inheritance/evaluator'
require 'integer-inheritance/column_types'

module IntegerInheritance
  class << self
    def mappings
      @mappings ||= {}
    end

    def describe(&block)
      Evaluator.instance.instance_eval(&block)
    end

    attr_accessor :column
  end

  self.column = 'sti_type'
end

module ActiveRecord
  Base.include(IntegerInheritance::Macro)
  ConnectionAdapters::TableDefinition.include(IntegerInheritance::ColumnTypes)
end