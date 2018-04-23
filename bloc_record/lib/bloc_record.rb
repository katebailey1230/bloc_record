module BlocRecord
   def self.connect_to(filename, :sqlite3)
     @database_filename = filename
	 @connect_to("db/address_bloc.db", :sqlite3)
   end
	
	def self.connect_to(filename, :pg)
     @database_filename = filename
	 @connect_to("db/address_bloc.db", :pg)
   end
 
   def self.database_filename
     @database_filename
   end
 end