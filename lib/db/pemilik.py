from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas Pemilik """
class Pemilik(BaseModel):
   user_id: int | None = None
   pemilik_nama: str
   pemilik_nik: str
   pemilik_tempat_lahir: str
   pemilik_tanggal_lahir: str
   pemilik_jenis_kelamin: str
   pemilik_alamat: str
   pemilik_pekerjaan: str
   pemilik_penghasilan: int | None = None

""" Kelas Pemilik (Patch) """
class PemilikPatch(BaseModel):
   user_id: int | None = -9999
   pemilik_nama: str | None = "kosong"
   pemilik_nik: str | None = "kosong"
   pemilik_tempat_lahir: str | None = "kosong"
   pemilik_tanggal_lahir: str | None = "kosong"
   pemilik_jenis_kelamin: str | None = "kosong"
   pemilik_alamat: str | None = "kosong"
   pemilik_pekerjaan: str | None = "kosong"
   pemilik_penghasilan: int | None = -9999

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================ KELAS PEMILIK ============================= """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_pemilik/")
def init_pemilik():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS pemilik(
				pemilik_id              INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id                 INTEGER NOT NULL,
				pemilik_nama            TEXT    NOT NULL,
				pemilik_nik             TEXT    NOT NULL,
				pemilik_tempat_lahir    TEXT    NOT NULL,
				pemilik_tanggal_lahir   TEXT    NOT NULL,
				pemilik_jenis_kelamin   TEXT    NOT NULL,
                pemilik_alamat          TEXT    NOT NULL,
                pemilik_pekerjaan       TEXT    NOT NULL,
                pemilik_penghasilan     INTEGER NOT NULL,
                FOREIGN KEY (user_id) REFERENCES user (user_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel pemilik"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel pemilik"})

# INSERT
@app.post("/insert_pemilik/")
def tambah_pemilik(u: Pemilik):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into pemilik (user_id, pemilik_nama, pemilik_nik, pemilik_tempat_lahir, pemilik_tanggal_lahir, pemilik_jenis_kelamin, pemilik_alamat, pemilik_pekerjaan, pemilik_penghasilan) values ({},'{}','{}','{}','{}','{}','{}','{}', {})""".format(u.user_id, u.pemilik_nama,u.pemilik_nik,u.pemilik_tempat_lahir,u.pemilik_tanggal_lahir,u.pemilik_jenis_kelamin,u.pemilik_alamat,u.pemilik_pekerjaan, u.pemilik_penghasilan))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan pemilik"})   
    finally:
        con.close()

    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        recs = []
        for row in cur.execute("""select * from pemilik where user_id = {} and pemilik_nik = '{}'""".format(u.user_id, u.pemilik_nik)):
            recs.append(row)
    except:
        return ({"status":"Error saat mengakses pemilik"})   
    finally:  	 
        con.close()
    
    return {"status":"Berhasil menambahkan pemilik", "data":recs[0]}

# SELECT
@app.get("/select_pemilik/")
def tampil_semua_pemilik():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from pemilik"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses pemilik"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_pemilik/{pemilik_id}",response_model = PemilikPatch)
def update_pemilik(response: Response, pemilik_id: int, u: PemilikPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from pemilik where pemilik_id = ?", (pemilik_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update pemilik set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.user_id!=-9999:
            if u.user_id!=None:
                sqlstr = sqlstr + " user_id = {} ,".format(u.user_id)
            else:  
                sqlstr = sqlstr + " user_id = null ,"
        if u.pemilik_nama!="kosong":
            if u.pemilik_nama!=None:
                sqlstr = sqlstr + " pemilik_nama = '{}' ,".format(u.pemilik_nama)
            else:  
                sqlstr = sqlstr + " pemilik_nama = null ,"
        if u.pemilik_nik!="kosong":
            if u.pemilik_nik!=None:
                sqlstr = sqlstr + " pemilik_nik = '{}' ,".format(u.pemilik_nik)
            else:
                sqlstr = sqlstr + " pemilik_nik = null ,"   
        if u.pemilik_tempat_lahir!="kosong":
            if u.pemilik_tempat_lahir!=None:
                sqlstr = sqlstr + " pemilik_tempat_lahir = '{}' ,".format(u.pemilik_tempat_lahir)
            else:
                sqlstr = sqlstr + " pemilik_tempat_lahir = null, "  
        if u.pemilik_tanggal_lahir!="kosong":
            if u.pemilik_tanggal_lahir!=None:
                sqlstr = sqlstr + " pemilik_tanggal_lahir = '{}' ,".format(u.pemilik_tanggal_lahir)
            else:
                sqlstr = sqlstr + " pemilik_tanggal_lahir = null, "
        if u.pemilik_jenis_kelamin!="kosong":
            if u.pemilik_jenis_kelamin!=None:
                sqlstr = sqlstr + " pemilik_jenis_kelamin = '{}' ,".format(u.pemilik_jenis_kelamin)
            else:
                sqlstr = sqlstr + " pemilik_jenis_kelamin = null, "  
        if u.pemilik_alamat!="kosong":
            if u.pemilik_alamat!=None:
                sqlstr = sqlstr + " pemilik_alamat = '{}' ,".format(u.pemilik_alamat)
            else:    
                sqlstr = sqlstr + " pemilik_alamat = null ,"
        if u.pemilik_pekerjaan!="kosong":
            if u.pemilik_pekerjaan!=None:
                sqlstr = sqlstr + " pemilik_pekerjaan = '{}' ,".format(u.pemilik_pekerjaan)
            else:    
                sqlstr = sqlstr + " pemilik_pekerjaan = null ,"
        if u.pemilik_penghasilan!=-9999:
            if u.pemilik_penghasilan!=None:
                sqlstr = sqlstr + " pemilik_penghasilan = {} ,".format(u.pemilik_penghasilan)
            else:    
                sqlstr = sqlstr + " pemilik_penghasilan = null ,"

        sqlstr = sqlstr[:-1] + " where pemilik_id={} ".format(pemilik_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/pemilik/{}".format(pemilik_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_pemilik/{pemilik_id}")
def delete_pemilik(pemilik_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from pemilik where pemilik_id={}".format(pemilik_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus pemilik"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus pemilik"}