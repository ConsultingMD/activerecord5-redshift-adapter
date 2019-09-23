module ActiveRecord
  module ConnectionAdapters
    class RedshiftColumn < Column #:nodoc:
      delegate :oid, :fmod, to: :sql_type_metadata

      def initialize(name, default, cast_type, sql_type = nil, null = true, default_function = nil, encoding = nil, auto_increment = nil)
        super name, default, cast_type, sql_type, null
        @null = null
        @default_function = default_function
        @encoding = encoding
        @auto_increment = auto_increment
      end

      def init_with(coder)
        super coder
        @encoding = coder["encoding"]
        @auto_increment = coder["auto_increment"]
      end

      def encode_with(coder)
        super coder
        coder["encoding"] = @encoding
        coder["auto_increment"] = @auto_increment
      end

      def encoding
        @encoding
      end

      def null
        @null
      end

      def auto_increment
        @auto_increment
      end
    end
  end
end
