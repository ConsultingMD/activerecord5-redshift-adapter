require 'active_record/tasks/database_tasks'

module ActiveRecord
  module Tasks
    class RedshiftDatabaseTasks
      ActiveRecord::Tasks::DatabaseTasks.module_eval { register_task(/redshift/i,   ActiveRecord::Tasks::PostgreSQLDatabaseTasks) }

      #DatabaseTasks.send :include, DatabaseTasksSQLServer
    end
  end
end
