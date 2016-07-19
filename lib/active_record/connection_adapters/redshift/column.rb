module ActiveRecord
  module ConnectionAdapters
    class RedshiftColumn < Column #:nodoc:
      delegate :oid, :fmod, to: :sql_type_metadata

      def initialize(name, default, sql_type_metadata, null = true, table_name= nil, default_function = nil)
        super name, default, sql_type_metadata, null, table_name, default_function, nil
      end
    end
  end
end
