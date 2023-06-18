from pydantic import BaseModel
import sqlite3
from fastapi import HTTPException, Response
from main import app

""" Kelas Investasi """
class Investasi(BaseModel):
   user_id: int | None = None
   proyek_id: int | None = None
   investasi_nilai: int | None = None
   investasi_waktu: str
   tanggal_transaksi: str

""" Kelas Investasi (Patch) """
class InvestasiPatch(BaseModel):
   user_id: int | None = -9999
   proyek_id: int | None = -9999
   investasi_nilai: int | None = -9999
   investasi_waktu: str | None = "kosong"
   tanggal_transaksi: str | None = "kosong"

""" ======================================================================== """
""" ------------------------------------------------------------------------ """
""" ============================ KELAS INVESTASI =========================== """
""" ------------------------------------------------------------------------ """
""" ======================================================================== """

# CREATE
@app.get("/create_investasi/")
def init_investasi():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		create_table = """ CREATE TABLE IF NOT EXISTS investasi(
				investasi_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id              INTEGER    NOT NULL,
                proyek_id            INTEGER    NOT NULL,
				investasi_nilai      INTEGER    NOT NULL,
				investasi_waktu      TEXT       NOT NULL,
				tanggal_transaksi    TEXT       NOT NULL,
                FOREIGN KEY (user_id) REFERENCES user (user_id),
                FOREIGN KEY (proyek_id) REFERENCES proyek (proyek_id)
			)  
			"""
		cur.execute(create_table)
		con.commit()
	except:
		return ({"status":"Error saat membuat tabel investasi"})  
	finally:
		con.close()
	return ({"status":"Berhasil membuat tabel investasi"})

# INSERT
@app.post("/insert_investasi/")
def tambah_investasi(u: Investasi):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("""insert into investasi (user_id, proyek_id, investasi_nilai, investasi_waktu, tanggal_transaksi) values ({},{},{},'{}','{}')""".format(u.user_id,u.proyek_id,u.investasi_nilai,u.investasi_waktu,u.tanggal_transaksi))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan investasi"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan investasi"}

# SELECT
@app.get("/select_investasi/")
def tampil_semua_investasi():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("select * from investasi"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses investasi"})   
	finally:  	 
		con.close()
	return {"data":recs}

# UPDATE
@app.patch("/update_investasi/{investasi_id}",response_model = InvestasiPatch)
def update_investasi(response: Response, investasi_id: int, u: InvestasiPatch ):
    try:
        print(str(u))
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from investasi where investasi_id = ?", (investasi_id,) )  #tambah koma untuk menandakan tupple
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e))) # misal database down    
    if existing_item:  #data ada, lakukan update
        sqlstr = "update investasi set " #asumsi minimal ada satu field update
        # todo: bisa di-refactor dan dirapikan
        if u.user_id!=-9999:
            if u.user_id!=None:
                sqlstr = sqlstr + " user_id = {} ,".format(u.user_id)
            else:  
                sqlstr = sqlstr + " user_id = null ,"
        if u.proyek_id!=-9999:
            if u.proyek_id!=None:
                sqlstr = sqlstr + " proyek_id = {} ,".format(u.proyek_id)
            else:
                sqlstr = sqlstr + " proyek_id = null ,"   
        if u.investasi_nilai!=-9999:
            if u.investasi_nilai!=None:
                sqlstr = sqlstr + " investasi_nilai = {} ,".format(u.investasi_nilai)
            else:
                sqlstr = sqlstr + " investasi_nilai = null, "  
        if u.investasi_waktu!="kosong":
            if u.investasi_waktu!=None:
                sqlstr = sqlstr + " investasi_waktu = '{}' ,".format(u.investasi_waktu)
            else:
                sqlstr = sqlstr + " investasi_waktu = null, "
        if u.tanggal_transaksi!="kosong":
            if u.tanggal_transaksi!=None:
                sqlstr = sqlstr + " tanggal_transaksi = '{}' ,".format(u.tanggal_transaksi)
            else:
                sqlstr = sqlstr + " tanggal_transaksi = null, "  

        sqlstr = sqlstr[:-1] + " where investasi_id={} ".format(investasi_id) 
        print(sqlstr)   
        try:
            cur.execute(sqlstr)
            con.commit()      
            response.headers["location"] = "/investasi/{}".format(investasi_id)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))        
    else:  # data tidak ada 404, item not found
        raise HTTPException(status_code=404, detail="Item Not Found") 
    con.close()
    return u

# delete
@app.delete("/delete_investasi/{investasi_id}")
def delete_investasi(investasi_id: int):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        sqlstr = "delete from investasi where investasi_id={}".format(investasi_id)            
        print(sqlstr) # debug
        cur.execute(sqlstr)
        con.commit()
    except:
        return ({"status":"Error saat menghapus investasi"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus investasi"}
