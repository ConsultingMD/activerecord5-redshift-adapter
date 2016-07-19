module ActiveRecord
  module ConnectionAdapters
    module Redshift
      module ColumnDumper
        # Adds +:array+ option to the default set provided by the
        # AbstractAdapter
        def prepare_column_options(column) # :nodoc:
          spec = super
          spec[:default] = "\"#{column.default_function}\"" if column.default_function
          spec
        end
      end
    end
  end
end
