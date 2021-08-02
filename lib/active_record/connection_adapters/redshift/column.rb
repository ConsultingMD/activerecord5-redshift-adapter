module ActiveRecord
  module ConnectionAdapters
    class RedshiftColumn < Column #:nodoc:
      delegate :oid, :fmod, to: :sql_type_metadata
      attr_accessor :identity

      def initialize(name, default, sql_type_metadata = nil, null = true, default_function = nil, identity = nil)
        super name, default, sql_type_metadata, null, default_function
        self.identity = identity
      end

      def is_identity?
        self.identity != nil
      end
    end
  end
end
