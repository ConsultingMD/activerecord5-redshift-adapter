module ActiveRecord
  module ConnectionAdapters
    module Redshift

      class SchemaDumper < ConnectionAdapters::SchemaDumper # :nodoc:
        private

        def prepare_column_options(column)
          spec = super
          spec[:identity] = [column.identity.first, column.identity.last] if column.is_identity?
          spec
        end

      end

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

