from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas Transaksi """
class Transaksi(BaseModel):
   user_id: int | None = None
   transaksi_jenis: str
   transaksi_nilai: int | None = None
   transaksi_waktu: str

""" Kelas Transaksi (Patch) """
class TransaksiPatch(BaseModel):
   user_id: int | None = -9999
   transaksi_jenis: str | None = "kosong"
   transaksi_nilai: int | None = -9999
   transaksi_waktu: str | None = "kosong"

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" =========================== KELAS TRANSAKSI ============================ """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_transaksi/")
def init_transaksi():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS transaksi(
				transaksi_id INTEGER PRIMARY KEY AUTOINCREMENT,
				user_id         INTEGER NOT NULL,
				transaksi_jenis TEXT    NOT NULL,
				transaksi_nilai INTEGER NOT NULL,
				transaksi_waktu TEXT    NOT NULL,
                FOREIGN KEY (user_id) REFERENCES user (user_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel transaksi"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel transaksi"})

# INSERT
@app.post("/insert_transaksi/")
def tambah_transaksi(u: Transaksi):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into transaksi (user_id, transaksi_jenis, transaksi_nilai, transaksi_waktu) values ({},'{}',{},'{}')""".format(u.user_id,u.transaksi_jenis,u.transaksi_nilai,u.transaksi_waktu))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan transaksi"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan transaksi"}

# SELECT
@app.get("/select_transaksi/")
def tampil_semua_transaksi():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from transaksi"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses transaksi"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_transaksi/{transaksi_id}",response_model = TransaksiPatch)
def update_transaksi(response: Response, transaksi_id: int, u: TransaksiPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from transaksi where transaksi_id = ?", (transaksi_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update transaksi set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.user_id!=-9999:
            if u.user_id!=None:
                sqlstr = sqlstr + " user_id = {} ,".format(u.user_id)
            else:  
                sqlstr = sqlstr + " user_id = null ,"
        if u.transaksi_jenis!="kosong":
            if u.transaksi_jenis!=None:
                sqlstr = sqlstr + " transaksi_jenis = '{}' ,".format(u.transaksi_jenis)
            else:
                sqlstr = sqlstr + " transaksi_jenis = null ,"   
        if u.transaksi_nilai!=-9999:
            if u.transaksi_nilai!=None:
                sqlstr = sqlstr + " transaksi_nilai = {} ,".format(u.transaksi_nilai)
            else:
                sqlstr = sqlstr + " transaksi_nilai = null, "  
        if u.transaksi_waktu!="kosong":
            if u.transaksi_waktu!=None:
                sqlstr = sqlstr + " transaksi_waktu = '{}' ,".format(u.transaksi_waktu)
            else:
                sqlstr = sqlstr + " transaksi_waktu = null, "

        sqlstr = sqlstr[:-1] + " where transaksi_id={} ".format(transaksi_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/transaksi/{}".format(transaksi_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_transaksi/{transaksi_id}")
def delete_transaksi(transaksi_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from transaksi where transaksi_id={}".format(transaksi_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus transaksi"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus transaksi"}
