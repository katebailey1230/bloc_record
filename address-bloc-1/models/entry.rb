require 'bloc_record/base'
 
class Entry < BlocRecord::Base
	 
  def to_s
    "Name: #{name}\nPhone Number: #{phone}\nEmail: #{email}"
  end
end
