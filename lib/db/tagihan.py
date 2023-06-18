from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas Tagihan """
class Tagihan(BaseModel):
   umkm_id: int | None = None
   tagihan_status: int | None = None
   tagihan_nilai: int | None = None
   tagihan_tgl: str

""" Kelas Tagihan (Patch) """
class TagihanPatch(BaseModel):
   umkm_id: int | None = -9999
   tagihan_status: int | None = -9999
   tagihan_nilai: int | None = -9999
   tagihan_tgl: str | None = "kosong"

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================= KELAS TAGIHAN ============================ """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_tagihan/")
def init_tagihan():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS tagihan(
				tagihan_id      INTEGER PRIMARY KEY AUTOINCREMENT,
				umkm_id         INTEGER NOT NULL,
				tagihan_status  INTEGER NOT NULL,
				tagihan_nilai   INTEGER NOT NULL,
				tagihan_tgl     TEXT    NOT NULL,
                FOREIGN KEY (umkm_id) REFERENCES umkm (umkm_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel tagihan"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel tagihan"})

# INSERT
@app.post("/insert_tagihan/")
def tambah_tagihan(u: Tagihan):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into tagihan (umkm_id, tagihan_status, tagihan_nilai, tagihan_tgl) values ({},{},{},'{}')""".format(u.umkm_id,u.tagihan_status,u.tagihan_nilai,u.tagihan_tgl))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan tagihan"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan tagihan"}

# SELECT
@app.get("/select_tagihan/")
def tampil_semua_tagihan():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from tagihan"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses tagihan"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_tagihan/{tagihan_id}",response_model = TagihanPatch)
def update_tagihan(response: Response, tagihan_id: int, u: TagihanPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from tagihan where tagihan_id = ?", (tagihan_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update tagihan set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.umkm_id!=-9999:
            if u.umkm_id!=None:
                sqlstr = sqlstr + " umkm_id = {} ,".format(u.umkm_id)
            else:  
                sqlstr = sqlstr + " umkm_id = null ,"
        if u.tagihan_status!=-9999:
            if u.tagihan_status!=None:
                sqlstr = sqlstr + " tagihan_status = {} ,".format(u.tagihan_status)
            else:
                sqlstr = sqlstr + " tagihan_status = null ,"   
        if u.tagihan_nilai!=-9999:
            if u.tagihan_nilai!=None:
                sqlstr = sqlstr + " tagihan_nilai = {} ,".format(u.tagihan_nilai)
            else:
                sqlstr = sqlstr + " tagihan_nilai = null, "  
        if u.tagihan_tgl!="kosong":
            if u.tagihan_tgl!=None:
                sqlstr = sqlstr + " tagihan_tgl = '{}' ,".format(u.tagihan_tgl)
            else:
                sqlstr = sqlstr + " tagihan_tgl = null, "

        sqlstr = sqlstr[:-1] + " where tagihan_id={} ".format(tagihan_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/tagihan/{}".format(tagihan_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_tagihan/{tagihan_id}")
def delete_tagihan(tagihan_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from tagihan where tagihan_id={}".format(tagihan_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus tagihan"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus tagihan"}

