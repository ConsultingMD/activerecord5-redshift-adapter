module ActiveRecord
  module ConnectionAdapters
    module Redshift
      module ColumnMethods
        # Defines the primary key field.
        # Use of the native PostgreSQL UUID type is supported, and can be used
        # by defining your tables as such:
        #
        #   create_table :stuffs, id: :uuid do |t|
        #     t.string :content
        #     t.timestamps
        #   end
        #
        # By default, this will use the +uuid_generate_v4()+ function from the
        # +uuid-ossp+ extension, which MUST be enabled on your database. To enable
        # the +uuid-ossp+ extension, you can use the +enable_extension+ method in your
        # migrations. To use a UUID primary key without +uuid-ossp+ enabled, you can
        # set the +:default+ option to +nil+:
        #
        #   create_table :stuffs, id: false do |t|
        #     t.primary_key :id, :uuid, default: nil
        #     t.uuid :foo_id
        #     t.timestamps
        #   end
        #
        # You may also pass a different UUID generation function from +uuid-ossp+
        # or another library.
        #
        # Note that setting the UUID primary key default value to +nil+ will
        # require you to assure that you always provide a UUID value before saving
        # a record (as primary keys cannot be +nil+). This might be done via the
        # +SecureRandom.uuid+ method and a +before_save+ callback, for instance.
        def primary_key(name, type = :primary_key, options = {})
          return super unless type == :uuid
          options[:default] = options.fetch(:default, 'uuid_generate_v4()')
          options[:primary_key] = true
          column name, type, options
        end

        def json(name, options = {})
          column(name, :json, options)
        end

        def jsonb(name, options = {})
          column(name, :jsonb, options)
        end
      end

      class ColumnDefinition < Struct.new(:name, :type, :options, :sql_type)
        def primary_key?
          options[:primary_key]
        end

        [:limit, :precision, :scale, :default, :null, :collation, :comment, :encoding, :auto_increment].each do |option_name|
          module_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{option_name}
              options[:#{option_name}]
            end
            def #{option_name}=(value)
              options[:#{option_name}] = value
            end
          CODE
        end
      end

      class TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
        include ColumnMethods

        private

        def create_column_definition(name, type, options)
          Redshift::ColumnDefinition.new name, type, options
        end

        def new_column_definition(name, type, options) # :nodoc:
          type = aliased_types(type.to_s, type)
          column = create_column_definition(name, type, options)
          column
        end
      end

      class Table < ActiveRecord::ConnectionAdapters::Table
        include ColumnMethods
      end
    end
  end
end
