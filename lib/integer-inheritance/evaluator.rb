# frozen_string_literal: true
module IntegerInheritance
  class Evaluator
    include Singleton

    def with(base_class_name, &block)
      @mapping = {}
      instance_eval(&block)
      (IntegerInheritance.mappings[base_class_name.to_s] ||= {}).merge!(@mapping)
    ensure
      @mapping = nil
    end

    def map(*sti_types, to:)
      full_class_name = to.to_s
      sti_types.each { |t| @mapping[t.to_i] = full_class_name }
    end
  end
end
