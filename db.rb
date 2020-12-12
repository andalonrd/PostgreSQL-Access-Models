# function for management of PostgresSQL databases, with ruby. 
# Made by Andrés Alonso Rodriguez PhD on 5/XII/2020

def open_db()
#this function creates a database door  
	begin 
		require 'pg'
		# please change the credentials for accessing the database when needed
		db_door = PG.connect(:host => "localhost", :port => 5432, :dbname => "Challenge4rb", :user => "postgres", :password => "Bdate81V05")
		return [db_door, "db ok"]
	rescue 
		return [nil,"db not ok"]
	end 
end

def do_in_db(sqlQuery)
# this function performs a sqlQuery in the database
	begin 
		db_door = open_db()
		if db_door[1] == "db ok" 
			outcome = db_door[0].exec(sqlQuery)  
			db_door[0].close()
			return [outcome,"query ok"]
		else 
			return [nil, db_door[1]]  
		end	
	rescue 
		return ["","query not ok"]
	end
end

def query_unpacker(query_out)

# this function builds up a string with the output from a query (query_out)
# if the query returns no values, an empty string will be outputed 

	out = ''
	query_out.each do |x|
		prs = x.keys
		prs.each do |y|
			out += x[y] + ','
		end
		out += ';'
	end
	return out 
end

def create_table(table,headings,types)

# this function creates a table in the database. it has the following arguments:
# table: the name of the table 
# headings: array containing the variable names of the table
# types: array containing the variable types of each variable defined in headings 

	nfields = headings.length;
	if nfields == types.length
		table_def = "drop table if exists #{table}; create table #{table} ("
		0.upto(nfields-1) do |i| 
			if i == 0 
				table_def += " #{headings[i]} #{types[i]} primary key"
			else 
				table_def += ", #{headings[i]} #{types[i]}"  
			end
		end
		table_def += " );"
		return do_in_db(table_def)
	else 
		return [nil, "wrong table definition"]
	end
end


#these are tests that show the functionability of the proposed library
#table = "access_control"
#headings = ["id","login","password","kind"]
#types = ["int","varchar(10)","varchar(10)","char(1)"]	
#s1 = create_table(table,headings,types)
#i1 = "Insert into access_control values (1,'Rose1','Crack','A');"
#i2 = "Insert into access_control values (2,'Thomas','Cat','U');"
#i3 = "Insert into access_control values (3,'Bolton','Roose','U');"
#i4 = "insert into access_control values (4,'James','Crack','U');"
#s2 = do_in_db(i1)
#s3 = do_in_db(i2)
#s4 = do_in_db(i3)
#s5 = do_in_db(i4)
#sel1 = "select * from access_control where password = 'Crack';"
#sel2 = "select * from access_control where (password = 'Crack' and login = 'Rose1');"
#sel3 = "select * from access_control where password = 'Mouse';"
#sel4 = "select * from access_control where (password = 'KittyA' and login = 'MarkT');"
#s6 = do_in_db(sel1)
#s7 = do_in_db(sel2)
#s8 = do_in_db(sel3)
#s9 = do_in_db(sel4)


#p s9
#p s8 
#p s7
#p s6
#p s5
#p s4  
#p s3
#p s2 
#p s1

#puts query_unpacker(s9[0])
#puts query_unpacker(s8[0])
#puts query_unpacker(s7[0])
#puts query_unpacker(s6[0])



