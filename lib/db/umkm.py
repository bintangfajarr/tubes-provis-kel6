from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas UMKM """
class Umkm(BaseModel):
    user_id: int | None = None
    pemilik_id: int | None = None
    umkm_nama: str
    umkm_kategori: str
    umkm_kota: str
    umkm_alamat: str
    umkm_foto: str
    umkm_deskripsi: str

""" Kelas UMKM (Patch) """
class UmkmPatch(BaseModel):
    user_id: int | None = -9999
    pemilik_id: int | None = -9999
    umkm_nama: str | None = "kosong"
    umkm_kategori: str | None = "kosong"
    umkm_kota: str | None = "kosong"
    umkm_alamat: str | None = "kosong"
    umkm_foto: str | None = "kosong"
    umkm_deskripsi: str | None = "kosong"

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================== KELAS UMKM ============================== """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_umkm/")
def init_umkm():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS umkm(
				umkm_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id         INTEGER NOT NULL,
                pemilik_id      INTEGER NOT NULL,
				umkm_nama       TEXT    NOT NULL,
				umkm_kategori   TEXT    NOT NULL,
                umkm_kota       TEXT    NOT NULL,
				umkm_alamat     TEXT    NOT NULL,
                umkm_foto       INTEGER,
				umkm_deskripsi  TEXT    NOT NULL,
                FOREIGN KEY (user_id) REFERENCES user (user_id),
                FOREIGN KEY (pemilik_id) REFERENCES pemilik (pemilik_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel umkm"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel umkm"})

# INSERT
@app.post("/insert_umkm/")
def tambah_umkm(u: Umkm):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into umkm (user_id, pemilik_id, umkm_nama, umkm_kategori, umkm_kota, umkm_alamat, umkm_foto, umkm_deskripsi) values ({},{},'{}','{}','{}','{}','{}','{}')""".format(u.user_id,u.pemilik_id,u.umkm_nama,u.umkm_kategori,u.umkm_kota,u.umkm_alamat,u.umkm_foto,u.umkm_deskripsi))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan umkm"})   
    finally:
        con.close()
    
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        recs = []
        for row in cur.execute("""select * from umkm where user_id = {} and pemilik_id = {}""".format(u.user_id,u.pemilik_id)):
            recs.append(row)
    except:
        return ({"status":"Error saat mengakses umkm"})   
    finally:  	 
        con.close()

    return {"status":"Berhasil menambahkan umkm", "data":recs[0]}

# SELECT
@app.get("/select_umkm/")
def tampil_semua_umkm():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from umkm"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses umkm"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_umkm/{umkm_id}",response_model = UmkmPatch)
def update_umkm(response: Response, umkm_id: int, u: UmkmPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from umkm where umkm_id = ?", (umkm_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update umkm set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.user_id!=-9999:
            if u.user_id!=None:
                sqlstr = sqlstr + " user_id = {} ,".format(u.user_id)
            else:  
                sqlstr = sqlstr + " user_id = null ,"
        if u.pemilik_id!=-9999:
            if u.pemilik_id!=None:
                sqlstr = sqlstr + " pemilik_id = {} ,".format(u.pemilik_id)
            else:
                sqlstr = sqlstr + " pemilik_id = null ,"   
        if u.umkm_nama!="kosong":
            if u.umkm_nama!=None:
                sqlstr = sqlstr + " umkm_nama = '{}' ,".format(u.umkm_nama)
            else:
                sqlstr = sqlstr + " umkm_nama = null, "  
        if u.umkm_kategori!="kosong":
            if u.umkm_kategori!=None:
                sqlstr = sqlstr + " umkm_kategori = '{}' ,".format(u.umkm_kategori)
            else:
                sqlstr = sqlstr + " umkm_kategori = null, "
        if u.umkm_kota!="kosong":
            if u.umkm_kota!=None:
                sqlstr = sqlstr + " umkm_kota = '{}' ,".format(u.umkm_kota)
            else:
                sqlstr = sqlstr + " umkm_kota = null, "
        if u.umkm_alamat!="kosong":
            if u.umkm_alamat!=None:
                sqlstr = sqlstr + " umkm_alamat = '{}' ,".format(u.umkm_alamat)
            else:
                sqlstr = sqlstr + " umkm_alamat = null, "  
        if u.umkm_foto!="kosong":
            if u.umkm_foto!=None:
                sqlstr = sqlstr + " umkm_foto = '{}' ,".format(u.umkm_foto)
            else:    
                sqlstr = sqlstr + " umkm_foto = null ,"
        if u.umkm_deskripsi!="kosong":
            if u.umkm_deskripsi!=None:
                sqlstr = sqlstr + " umkm_deskripsi = '{}' ,".format(u.umkm_deskripsi)
            else:    
                sqlstr = sqlstr + " umkm_deskripsi = null ,"

        sqlstr = sqlstr[:-1] + " where umkm_id={} ".format(umkm_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/umkm/{}".format(umkm_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_umkm/{umkm_id}")
def delete_umkm(umkm_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from umkm where umkm_id={}".format(umkm_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus umkm"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus umkm"}
