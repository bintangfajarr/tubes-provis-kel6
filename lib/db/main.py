from fastapi import HTTPException
import sqlite3
import jwt

from app import *
from user import *
from transaksi import *
from pemilik import *
from umkm import *
from proyek import *
from tagihan import *
from investasi import *

@app.get("/")
def read_root():
    return {"FastAPI Fundalize": "Berhasil dijalankan!"}

@app.get("/init/")
def init_db():
    try:
        init_user()
        init_transaksi()
        init_pemilik()
        init_umkm()
        init_proyek()
        init_tagihan()
        init_investasi()
    except:
        return ({"status":"Error saat membuat tabel"})
    return ({"status":"Berhasil membuat tabel"})

@app.post("/login")
def login(user: User):
    try:
        DB_NAME = "fundalize.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        recs = []
        for row in cur.execute("select * from user"):
            recs.append(row)
        
        stored_user = None
        for rec in recs:
            if rec[2] == user.user_email:
                stored_user = rec
                break
        
        if stored_user is None:
            raise HTTPException(status_code=400, detail="Email tidak terdaftar")
        
        if stored_user[4] != user.user_password:
            raise HTTPException(status_code=400, detail="Password salah")
        
        # Generate a JWT token
        jwt_payload = {
            "user_id": stored_user[0],
            "user_nama": stored_user[1],
            "user_email": stored_user[2],
            "user_no_telp": stored_user[3],
            "user_password": stored_user[4],
            "user_role": stored_user[5],
            "user_saldo": stored_user[6],
        }

        jwt_token = jwt.encode(jwt_payload, "bffrv6", algorithm="HS256")

        return {"token": jwt_token}
    except:
        return {"status": "Data email atau password salah"}
    finally:
        con.close()

@app.get("/get_data_pendanaan/")
def get_data_pendanaan():
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("SELECT * FROM pemilik JOIN umkm ON pemilik.pemilik_id = umkm.pemilik_id JOIN proyek ON umkm.umkm_id = proyek.umkm_id"):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses proyek"})   
	finally:  	 
		con.close()
	return {"data":recs}

@app.get("/get_data_pendanaan_user/{user_id}")
def get_data_pendanaan_user(user_id: int):
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("SELECT * FROM pemilik JOIN umkm ON pemilik.pemilik_id = umkm.pemilik_id JOIN proyek ON umkm.umkm_id = proyek.umkm_id WHERE umkm.user_id = {}".format(user_id)):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses proyek"})   
	finally:  	 
		con.close()
	return {"data":recs}

@app.get("/get_investasi_user/{user_id}")
def get_investasi_user(user_id: int):
	try:
		DB_NAME = "fundalize.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		for row in cur.execute("SELECT * FROM investasi JOIN (SELECT * FROM pemilik JOIN umkm ON pemilik.pemilik_id = umkm.pemilik_id JOIN proyek ON umkm.umkm_id = proyek.umkm_id) as pendanaan ON investasi.proyek_id = pendanaan.proyek_id WHERE investasi.user_id = {}".format(user_id)):
			recs.append(row)
	except:
		return ({"status":"Error saat mengakses proyek"})   
	finally:  	 
		con.close()
	return {"data":recs}