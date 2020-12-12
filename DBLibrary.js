function createTable(table, headings, types) {
    var Client = require('pg').Client;
    var client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'Sprint1',
        password: 'Bdate81V05',
        port: 5432
    });
    var nFields = headings.length;
    var table_def;
    if (nFields == types.length) {
        table_def = "drop table if exists " + table + "; create table " + table + " (";
        var i;
        for (i = 0; i < nFields; i++) {
            if (i == 0) {
                table_def += headings[i] + " " + types[i] + " primary key";
            }
            else {
                table_def += ", " + headings[i] + " " + types[i];
            }
        }
        table_def += ");";
    }
    else {
        table_def = "table not well defined";
    }
    client.connect();
    client.query(table_def, function (err, res) {
        if (err) {
            console.error(err);
            return;
        }
        console.log("Table ok");
        client.end();
    });
}
function doInDB(query) {
    var Client = require('pg').Client;
    var client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'Sprint1',
        password: 'Bdate81V05',
        port: 5432
    });
    client.connect();
    client.query(query, function (err, res) {
        if (err) {
            console.error(err);
            return;
        }
        console.log("Query ok");
        client.end();
    });
}
function getFromDB(query) {
    var Client = require('pg').Client;
    var client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'Sprint1',
        password: 'Bdate81V05',
        port: 5432
    });
    client.connect();
    client.query(query, function (err, res) {
        if (err) {
            console.error(err);
            return;
        }
        for (var _i = 0, _a = res.rows; _i < _a.length; _i++) {
            var row = _a[_i];
            console.log(row);
        }
        client.end();
    });
}
var hds = ["id", "login", "password"];
var tps = ["int", "varchar(10)", "varchar(10)"];
var sql1 = "insert into logins values (1,'Plove','cute24');";
var sql2 = "insert into logins values (2,'Ploony','cute24');";
var sql3 = "insert into logins values (3,'Plusky','feral23');";
var sql4 = "insert into logins values (4,'Plushy','missy4');";
var sql5 = "insert into logins values (5,'Kinky','feral23');";
var sql6 = "select * from logins;";

async function runsqls(){
    try{
        const s1 = await createTable("logins", hds,tps)
        const s2 = await doInDB(sql1)
        const s3 = await doInDB(sql2)
        const s4 = await doInDB(sql3)
        const s5 = await doInDB(sql4)
        const s6 = await doInDb(sql5)
        const s7 = await getFromDb(sql6)
    }
    catch (error) {
        console.log(error)
    }
}
//createTable("logins", hds,tps)
//doInDB(sql1)
//doInDB(sql2)
//doInDB(sql3)
//doInDB(sql4)
//doInDB(sql5)
//getFromDB(sql6);
runsqls()
