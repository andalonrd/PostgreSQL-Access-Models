class Data_item

require 'fileutils'
require 'date'
require './db.rb'
require './Access.rb'

def initialize(access,name)
	  
	sql1 = "select * from dataWarehouse where ( id = '#{access.id}' name = '#{name}' and status = 1;)"  
	found = do_in_db(sql1)
	unless found[0] = "" 
		query_result = query_unpacker(found[0])
		@id = query_result[0]
		@user_id = query_result[1]
		@name = query_result[2]
		@in_date = query_result[3]
		@status = query_result[4]
		@exp_date = query_result[5]
	else 	
		@id = File.read("FileN.txt").to_i + 1
		File.write("FileN.txt",@id.to_s)
		@name = name 
		@user_id = access.id 
		@in_date = Date.today 
		@status = 1
		@exp_date = Date.new(2000,1,1)
		
	end
end 

def expired ()
	if @expire > Date.today
		File.delete(".\\warehouse\\#{@user}\\@name") if File.exist?(".\\warehouse\\#{@user}\\@name")
		@status = 0
		return "File expired"
	else 
		Return "File is still valid"
	end
end 

def retrieve (path)

	unless @status == 0 
		FileUtils.cp(".\\warehouse\\#{@user_id}\\#{@name}", path)
		return "File has been Retrieved" 
	else 
		return "File is expired"
	end 
		
end 

def store (path,span)

	@exp_date = @in_date + span 
	in_date_s = @in_date.to_s
	exp_date_s = @exp_date.to_s 
	sql2 = "insert into dataWarehouse values ( #{@id}, #{@user_id},#{in_date_s},#{exp_date_s},#{@status});" 
	end_path = ".\\warehouse\\#{@user_id}"
	
	unless File.exists?(end_path)
		FileUtils.mkdir_p(end_path )
	end
	FileUtils.cp(path + @name,end_path)
	return end_path
end

def update_exp_date (more_span)
	@exp_date += more_span
	exp_date_s = @exp_date.to_s
	sql3 = "update datawarehouse set exp_date = #{exp_date_s} where id = #{@id}"
	return sql3
end 

end 

table = "dataWarehouse"
headings = ["id","owner","in_date","exp_date","status"]
types = ["int","int","varchar(10)","varchar(10)","int"]	
a = create_table(table,headings,types)
p a
b = Access.new("MarkT","KittyA","A")
p b
puts b.id
c = Data_item.new(b,"Memorando.docx")

inpath = "C:\\Users\\Andres Alonso\\Desktop\\OnGoing\\MinTic 2020\\Software Development\\Documents\\"
puts inpath 
c.store(inpath,15)
outpath = "C:\\Users\\Andres Alonso\\Desktop"
c.retrieve(outpath)