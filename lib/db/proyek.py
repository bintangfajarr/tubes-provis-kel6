from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas Proyek """
class Proyek(BaseModel):
   umkm_id: int | None = None
   proyek_target: int | None = None
   proyek_terkumpul: int | None = None
   proyek_tgl_masuk: str
   proyek_tgl_keluar: str

""" Kelas Proyek (Patch) """
class ProyekPatch(BaseModel):
   umkm_id: int | None = -9999
   proyek_target: int | None = -9999
   proyek_terkumpul: int | None = -9999
   proyek_tgl_masuk: str | None = "kosong"
   proyek_tgl_keluar: str | None = "kosong"

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================= KELAS PROYEK ============================= """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_proyek/")
def init_proyek():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS proyek(
				proyek_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                umkm_id           INTEGER   NOT NULL,
				proyek_target     INTEGER   NOT NULL,
				proyek_terkumpul  INTEGER   NOT NULL,
                proyek_tgl_masuk  TEXT      NOT NULL,
                proyek_tgl_keluar TEXT      NOT NULL,
                FOREIGN KEY (umkm_id) REFERENCES umkm (umkm_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel proyek"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel proyek"})

# INSERT
@app.post("/insert_proyek/")
def tambah_proyek(u: Proyek):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into proyek (umkm_id, proyek_target, proyek_terkumpul, proyek_tgl_masuk, proyek_tgl_keluar) values ({},{},{},'{}','{}')""".format(u.umkm_id,u.proyek_target,u.proyek_terkumpul,u.proyek_tgl_masuk,u.proyek_tgl_keluar))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan proyek"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan proyek"}

# SELECT
@app.get("/select_proyek/")
def tampil_semua_proyek():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from proyek"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses proyek"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_proyek/{proyek_id}",response_model = ProyekPatch)
def update_proyek(response: Response, proyek_id: int, u: ProyekPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from proyek where proyek_id = ?", (proyek_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update proyek set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.umkm_id!=-9999:
            if u.umkm_id!=None:
                sqlstr = sqlstr + " umkm_id = {} ,".format(u.umkm_id)
            else:  
                sqlstr = sqlstr + " umkm_id = null ,"
        if u.proyek_target!=-9999:
            if u.proyek_target!=None:
                sqlstr = sqlstr + " proyek_target = {} ,".format(u.proyek_target)
            else:
                sqlstr = sqlstr + " proyek_target = null ,"   
        if u.proyek_terkumpul!=-9999:
            if u.proyek_terkumpul!=None:
                sqlstr = sqlstr + " proyek_terkumpul = {} ,".format(u.proyek_terkumpul)
            else:
                sqlstr = sqlstr + " proyek_terkumpul = null, "  
        if u.proyek_tgl_masuk!="kosong":
            if u.proyek_tgl_masuk!=None:
                sqlstr = sqlstr + " proyek_tgl_masuk = '{}' ,".format(u.proyek_tgl_masuk)
            else:
                sqlstr = sqlstr + " proyek_tgl_masuk = null, "
        if u.proyek_tgl_keluar!="kosong":
            if u.proyek_tgl_keluar!=None:
                sqlstr = sqlstr + " proyek_tgl_keluar = '{}' ,".format(u.proyek_tgl_keluar)
            else:
                sqlstr = sqlstr + " proyek_tgl_keluar = null, "  

        sqlstr = sqlstr[:-1] + " where proyek_id={} ".format(proyek_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/proyek/{}".format(proyek_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_proyek/{proyek_id}")
def delete_proyek(proyek_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from proyek where proyek_id={}".format(proyek_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus proyek"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus proyek"}
