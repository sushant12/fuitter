class AddSchemaToSearchPath < ActiveRecord::Migration[5.1]
  def up
  	current_database = execute("SELECT current_database();")[0]["current_database"]
    execute %{ALTER DATABASE #{current_database} SET search_path TO "$user", public, "api";}
  end

  def down
  end
end
