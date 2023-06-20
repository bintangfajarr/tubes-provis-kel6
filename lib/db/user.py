from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

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

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================== KELAS USER ============================== """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_user/")
def init_user():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS user(
				user_id         INTEGER PRIMARY KEY AUTOINCREMENT,
				user_nama       TEXT    NOT NULL,
				user_email      TEXT    NOT NULL,
				user_no_telp    TEXT    NOT NULL,
				user_password   TEXT    NOT NULL,
				user_role       TEXT    NOT NULL,
                user_saldo      INTEGER NOT NULL
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel User"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel User"})

# INSERT
@app.post("/insert_user/")
def tambah_user(u: User):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into user (user_nama,user_email,user_no_telp,user_password,user_role,user_saldo) values ('{}','{}','{}','{}','{}',{})""".format(u.user_nama,u.user_email,u.user_no_telp,u.user_password,u.user_role,u.user_saldo))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan user"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan user"}

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
		return ({"status":"Error saat mengakses user"})   
	finally:  	 
		con.close()
	return {"data":recs}
            
# UPDATE
@app.patch("/update_user/{user_id}",response_model = UserPatch)
def update_user(response: Response, user_id: int, u: UserPatch):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from user where user_id = ?", (user_id,))  # tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))  # misal database down
    if existing_item:  # data ada, lakukan update
        # asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        sqlstr = "UPDATE user SET "
        
        if u.user_nama != "kosong":
            if u.user_nama is not None:
                sqlstr += "user_nama = '{}', ".format(u.user_nama)
            else:
                sqlstr += "user_nama = NULL, "
        
        if u.user_email != "kosong":
            if u.user_email is not None:
                sqlstr += "user_email = '{}', ".format(u.user_email)
            else:
                sqlstr += "user_email = NULL, "
        
        if u.user_no_telp != "kosong":
            if u.user_no_telp is not None:
                sqlstr += "user_no_telp = '{}', ".format(u.user_no_telp)
            else:
                sqlstr += "user_no_telp = NULL, "
        
        if u.user_password != "kosong":
            if u.user_password is not None:
                sqlstr += "user_password = '{}', ".format(u.user_password)
            else:
                sqlstr += "user_password = NULL, "
        
        if u.user_role != "kosong":
            if u.user_role is not None:
                sqlstr += "user_role = '{}', ".format(u.user_role)
            else:
                sqlstr += "user_role = NULL, "
        
        if u.user_saldo != -9999:
            if u.user_saldo is not None:
                sqlstr += "user_saldo = {}, ".format(u.user_saldo)
            else:
                sqlstr += "user_saldo = NULL, "
        
        sqlstr = sqlstr[:-2]  # Remove the trailing comma and space
        
        sqlstr += " WHERE user_id = {}".format(user_id)
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
        return ({"status":"Error saat menghapus user"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus user"}
