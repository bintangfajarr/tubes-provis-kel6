""" import """
from typing import Union
from fastapi import FastAPI, Response, HTTPException
from pydantic import BaseModel
import sqlite3

""" Kelas User """
class User(BaseModel):
   user_nama: str
   user_email: str
   user_no_telp: str
   user_password: str
   user_role: str
   user_saldo: int | None = None

""" Kelas User (Patch) """
class UserPatch(BaseModel):
   user_nama: str | None = "kosong"
   user_email: str | None = "kosong"
   user_no_telp: str | None = "kosong"
   user_password: str | None = "kosong"
   user_role: str | None = "kosong"
   user_saldo: int | None = -9999

app = FastAPI()

# test
@app.get("/")
def read_root():
    return {"FastAPI Fundalize": "Berhasil dijalankan!"}

# CREATE database.
@app.get("/init/")
def init_db():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE user(
				user_id INTEGER PRIMARY KEY AUTOINCREMENT,
				user_nama   TEXT    NOT NULL,
				user_email  TEXT    NOT NULL,
				user_no_telp    TEXT    NOT NULL,
				user_password   TEXT    NOT NULL,
				user_role       TEXT    NOT NULL,
                user_saldo  INTEGER     NOT NULL
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat Database"})  
	finally:
		con.close()
	return ({"status":"Database berhasil dibuat"})

# INSERT
@app.post("/insert_user/")
def tambah_user(u: User):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into user (user_nama,user_email,user_no_telp,user_password,user_role,user_saldo) values ( '{}','{}','{}','{}','{}',{})""".format(u.user_nama,u.user_email,u.user_no_telp,u.user_password,u.user_role,u.user_saldo))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan user"})   
    finally: 	 
        con.close()
    return {"status":"User berhasil ditambahkan"}

# SELECT
@app.get("/select_user/")
def tampil_semua_user():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from user"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses userser"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_user/{user_id}",response_model = UserPatch)
def update_user(response: Response, user_id: int, u: UserPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from user where user_id = ?", (user_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down  
        
    if existing_item:  #data ada, lakukan update
        sqlstr = "update user set " #asumsi miuser_idal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.user_nama!="kosong":
            if u.user_nama!=None:
                sqlstr = sqlstr + " user_nama = '{}' ,".format(u.user_nama)
            else:  
                sqlstr = sqlstr + " user_nama = null ,"
        
        if u.user_email!="kosong":
            if u.user_email!=None:
                sqlstr = sqlstr + " user_email = '{}' ,".format(u.user_email)
            else:
                sqlstr = sqlstr + " user_email = null ,"
        
        if u.user_no_telp!="kosong":
            if u.user_no_telp!=None:
                sqlstr = sqlstr + " user_no_telp = '{}' ,".format(u.user_no_telp)
            else:
                sqlstr = sqlstr + " user_no_telp = null, "  

        if u.user_password!="kosong":
            if u.user_password!=None:
                sqlstr = sqlstr + " user_password = '{}' ,".format(u.user_password)
            else:
                sqlstr = sqlstr + " user_password = null, "

        if u.user_role!="kosong":
            if u.user_role!=None:
                sqlstr = sqlstr + " user_role = '{}' ,".format(u.user_role)
            else:
                sqlstr = sqlstr + " user_role = null, "  

        if u.user_saldo!=-9999:
            if u.user_saldo!=None:
                sqlstr = sqlstr + " user_saldo = {} ,".format(u.user_saldo)
            else:    
                sqlstr = sqlstr + " user_saldo = null ,"

        sqlstr = sqlstr[:-1] + " where user_id={} ".format(user_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/user/{}".format(user_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))   
        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found")
    
    con.close()
    return u

# delete
@app.delete("/delete_user/{user_id}")
def delete_user(user_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from user where user_id={}".format(user_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus Uuser"})   
    finally:   
        con.close()
        
    return {"status":"User berhasil dihapus"}
