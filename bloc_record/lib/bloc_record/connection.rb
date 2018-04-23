require 'pg'
require 'sqlite3'

 
 module Connection
   def connection
     IF @connection ||= SQLite3::Database.new(BlocRecord.database_filename)?
	   BlocRecord.connect_to("db/address_bloc.db", :sqlite3)
	   else
	   BlocRecord.connect_to("db/address_bloc.db", :pg)   
   end
end