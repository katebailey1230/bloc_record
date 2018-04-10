require 'sqlite3'
 
 module Selection
	 def find(*ids)
     if ids.length == 1
       find_one(ids.first)
     else
       rows = connection.execute <<-SQL
         SELECT #{columns.join ","} FROM #{table}
         WHERE id IN (#{ids.join(",")});
       SQL
 
       rows_to_array(rows)
     end
   end	 

   def find_one(id)
	if (id < 0) || (id == nil)
		puts "That ID is not valid. Please try again."
	else
     row = connection.get_first_row <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       WHERE id = #{id};
     SQL
 
     init_object_from_row(row)
   end

def find_by(attribute, value)
     rows = connection.execute <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       WHERE #{attribute} = #{BlocRecord::Utility.sql_strings(value)};
     SQL
 
     rows_to_array(rows)
   end

def method_missing(method, *args, &block)
	if method == :find_by_name
		find_by(:name, *args[i])
	end
end

def find_each(options = {})
	rows = connection.execute <<-SQL
	  SELECT #{columns.join ","} FROM #{table}
	  LIMIT #(options[:batch_size]);
	SQL

	for row in rows_to_array(rows)
		yield(row)
end
end

def find_in_batches(options = {})
	rows = connection.execute <<-SQL
	  SELECT #{columns.join ","} FROM #{table}
	  LIMIT #(options[:batch_size])
	  OFFSET #(options[:start]);
	SQL

	for row in rows_to_array(rows)
		yield(row)
end
end

def take(num=1)
     if num > 1
       rows = connection.execute <<-SQL
         SELECT #{columns.join ","} FROM #{table}
         ORDER BY random()
         LIMIT #{num};
       SQL
 
       rows_to_array(rows)
     else
       take_one
     end
   end

def take_one
     row = connection.get_first_row <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       ORDER BY random()
       LIMIT 1;
     SQL
 
     init_object_from_row(row)
   end

def first
     row = connection.get_first_row <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       ORDER BY id ASC LIMIT 1;
     SQL
 
     init_object_from_row(row)
   end
 
   def last
     row = connection.get_first_row <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       ORDER BY id DESC LIMIT 1;
     SQL
 
     init_object_from_row(row)
   end

def all
     rows = connection.execute <<-SQL
       SELECT #{columns.join ","} FROM #{table};
     SQL
 
     rows_to_array(rows)
   end

private
 def init_object_from_row(row)
     if row
       data = Hash[columns.zip(row)]
       new(data)
     end
   end

   def rows_to_array(rows)
     rows.map { |row| new(Hash[columns.zip(row)]) }
   end
 end