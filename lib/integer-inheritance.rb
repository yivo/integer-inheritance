# encoding: utf-8
# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/core_ext/string'
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

    attr_accessor :default_column
  end

  self.default_column = 'inheritance_type'
end

class ActiveRecord::Base
  include IntegerInheritance::Macro
end

class ActiveRecord::ConnectionAdapters::TableDefinition
  include IntegerInheritance::ColumnTypes
end
