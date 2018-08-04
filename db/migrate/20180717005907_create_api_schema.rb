class CreateApiSchema < ActiveRecord::Migration[5.1]
  def up
  	execute <<-SQL
  		CREATE SCHEMA "api";
  	SQL
  end

  def down
  	execute <<-SQL
  		DROP SCHEMA "api" CASCADE;
  	SQL
  end
end
