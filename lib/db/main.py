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