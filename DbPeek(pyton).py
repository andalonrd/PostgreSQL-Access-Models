dbin = { 'user' : "postgres", 'password': "Bdate81V05", 'host': "localhost", 'database': "Sprint1" } 
# Made by Andres Alonso Rodríghez PhD, 3/12/2020
# This is a library for providing basic management of PostgresSQL dabases from python. 
# it starts a connection to a database, then does two kind of queries. The first kind makes changes within the database without extractiong a result
# the second kind queries data from it, mainly by executing a select statement. 

def open_db():
    # this opens the connection to the database
    import psycopg2
    try :
        db_door = psycopg2.connect(user= dbin['user'] , password= dbin['password'], host= dbin['host'], database = dbin['database']) 
        # this command induces permanent changes in the database after executing any SQL statement
        db_door.set_session(autocommit = True)
        return [db_door,'Running']
    except:
        status = 'Opps'
        db_door = None 
        return[None,'Opps'] 
    
def do_in_db(query) :
    # this exectures a query into db_data that makes a change in the database, without providing any feedback
    db_state = open_db()
    if db_state[1] == 'Running':
        try: 
            courier = db_state[0].cursor()
            courier.execute(query)
            courier.close()
            db_state[0].close()
            return  "Success"
        except: return  "Failure"

def query(query) :
    # this executes a query into db_data that provides feedback
    db_state = open_db() 
    if db_state[1] == 'Running' :  
        try:
            courier = db_state[0].cursor()
            courier.execute(query)
            output = courier.fetchall()
            db_state[0].close()
            return [output, "Success"]
        except: return [None, "Failure"]
    else: return [None, 'Opps']    

def make_backup(table) :
    queryT = "select * from " + table
    bk = query(dbin,queryT)
    line = ""
    len_record = len(bk[0][0])
    for record in bk[0] :
        for i in range(len_record):
            if i < len_record - 1 :
                line += str(record[i]) + "," 
            else : line += str(record[i]) + "\n"
    with open(table, mode = "w" ) as f :
        f.write(line)         
    return line  

def create_table(table,headings,types):
    if len(headings) == len(types) :
        nfields = len(headings)
        table_def = "drop table if exists " + table +"; create table " + table + " (" 
        for i in range(nfields) :
            if i== 0 :
                table_def += headings[i] + " " + types[i] + " primary key" 
            else : 
               table_def += ", " + headings[i] + " " + types[i]  
        table_def += ");"
        return do_in_db(table_def)

    else : return "Wrong table definition"  

def date_from_db(string_date):
    from datetime import date 
    rd = string_date.split("-")
    return date(rd[0],rd[1],rd[2])

    
# the basic commands are above this line. Below there are some examples that show how the library works. To make them active 
# just remove the "#" 


#B = create_table(dbin, "logins", ["id","login","password"],["int","varchar(10)","varchar(10)"]) 
#sql_1 = "insert into logins values (1,'Plove','cute24');"
#sql_3 = "insert into logins values (2,'Ploony','cute24');"
#sql_2 = "select * from logins where password = 'cute24';"

#print(do_in_db(dbin,sql_1))
#print(do_in_db(dbin,sql_3))
#A = query(sql_2)
#print(A[0])
#print(A[1])
#A = make_backup(dbin,"logins")
#print(A)

#print(B)

        




        








  