class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.datetime :time_run
	  t.string :import_file
	  
      t.timestamps
    end
  end
end
