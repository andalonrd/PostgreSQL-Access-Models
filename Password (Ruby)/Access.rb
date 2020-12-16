class Access 

attr_reader :access, :id 

def initialize(login,password,kind)
	@id = File.read("id_passwords.txt").to_i+1
	@login = login
	@password = password
	@kind = "U"
	@table = "access_control"
	@access = 0
	File.write("id_passwords.txt",@id.to_s)
end

def grant_access()
	query = "select * from #{@table} where ( login = '#{@login}' and password = '#{@password}');" 
	lock = do_in_db(query)
	if lock[1] == "db not ok" 
		return "Database Error"
	elsif 
		qout = query_unpacker(lock[0])
		if qout == ""
			return "access denied"
		else 
			@access = 1
			return "access granted"	
		end 
	end 
end 	

def add()
	query = "insert into #{@table} values (#{@id}, '#{@login}','#{@password}','#{@kind}');"
	flag = do_in_db(query)[1]
	if flag == "query ok" 
		return "New user added"
	else 
		return "failure"
	end
end 
end 

#create_table("access_control",["id","login","password","kind"],["int","varchar(10)","varchar(10)","char(1)"])

#a = Access.new("MarkT","KittyA","A")
#b = Access.new("JuneB", "Peachy22","U")
#c = Access.new("JessieK","Twinkle","U")
#d = Access.new("MarieH", "Trashy", "U")
#e = Access.new("NateS","Twinkle", "A")
	
#puts(a.add())
#puts(b.add())
#puts(c.add())
#puts(d.add())
#puts(a.grant_access())
#puts(d.grant_access())
#puts(e.grant_access())
#puts(e.access)
#puts(d.access)
	