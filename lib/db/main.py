""" IMPORT """
from typing import Union
from fastapi import FastAPI, Response, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import sqlite3
# from datetime import datetime

# Kelas-kelas #
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

""" Kelas Pemilik """
class Pemilik(BaseModel):
   pemilik_nama: str
   pemilik_nik: str
   pemilik_tempat_lahir: str
   pemilik_tanggal_lahir: str
   pemilik_jenis_kelamin: str
   pemilik_alamat: str
   pemilik_pekerjaan: str

""" Kelas Pemilik (Patch) """
class PemilikPatch(BaseModel):
   pemilik_nama: str | None = "kosong"
   pemilik_nik: str | None = "kosong"
   pemilik_tempat_lahir: str | None = "kosong"
   pemilik_tanggal_lahir: str | None = "kosong"
   pemilik_jenis_kelamin: str | None = "kosong"
   pemilik_alamat: str | None = "kosong"
   pemilik_pekerjaan: str | None = "kosong"


""" Kelas UMKM """
class Umkm(BaseModel):
   user_id: int | None = None
   pemilik_id: int | None = None
   umkm_nama: str
   umkm_kategori: str
   umkm_alamat: str
   umkm_foto: str
   umkm_deskripsi: str

""" Kelas UMKM (Patch) """
class UmkmPatch(BaseModel):
   user_id: int | None = -9999
   pemilik_id: int | None = -9999
   umkm_nama: str | None = "kosong"
   umkm_kategori: str | None = "kosong"
   umkm_alamat: str | None = "kosong"
   umkm_foto: str | None = "kosong"
   umkm_deskripsi: str | None = "kosong"

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

# new
app = FastAPI()

app.add_middleware(
 CORSMiddleware,
 allow_origins=["*"],
 allow_credentials=True,
 allow_methods=["*"],
 allow_headers=["*"],
)

# test
@app.get("/")
def read_root():
    return {"FastAPI Fundalize": "Berhasil dijalankan!"}

@app.get("/init/")
def init_db():
    init_user()
    init_transaksi()
    init_pemilik()
    init_umkm()
    init_proyek()
    init_tagihan()
    init_investasi()

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
		create_table = """ CREATE TABLE user(
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
        sqlstr = "update user set " #asumsi minimal ada satu field update
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
        return ({"status":"Error saat menghapus user"})   
    finally:   
        con.close()
    return {"status":"Berhasil menghapus user"}

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
		create_table = """ CREATE TABLE transaksi(
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
		create_table = """ CREATE TABLE pemilik(
				pemilik_id              INTEGER PRIMARY KEY AUTOINCREMENT,
				pemilik_nama            TEXT    NOT NULL,
				pemilik_nik             TEXT    NOT NULL,
				pemilik_tempat_lahir    TEXT    NOT NULL,
				pemilik_tanggal_lahir   TEXT    NOT NULL,
				pemilik_jenis_kelamin   TEXT    NOT NULL,
                pemilik_alamat          TEXT    NOT NULL,
                pemilik_pekerjaan       TEXT    NOT NULL
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
        cur.execute("""insert into pemilik (pemilik_nama, pemilik_nik, pemilik_tempat_lahir, pemilik_tanggal_lahir, pemilik_jenis_kelamin, pemilik_alamat, pemilik_pekerjaan) values ('{}','{}','{}','{}','{}','{}','{}')""".format(u.pemilik_nama,u.pemilik_nik,u.pemilik_tempat_lahir,u.pemilik_tanggal_lahir,u.pemilik_jenis_kelamin,u.pemilik_alamat,u.pemilik_pekerjaan))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan pemilik"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan pemilik"}

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
		create_table = """ CREATE TABLE umkm(
				umkm_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id         INTEGER NOT NULL,
                pemilik_id      INTEGER NOT NULL,
				umkm_nama       TEXT    NOT NULL,
				umkm_email      TEXT    NOT NULL,
				umkm_no_telp    TEXT    NOT NULL,
				umkm_password   TEXT    NOT NULL,
				umkm_role       TEXT    NOT NULL,
                umkm_saldo      INTEGER NOT NULL,
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
        cur.execute("""insert into umkm (user_id, pemilik_id, umkm_nama, umkm_kategori, umkm_alamat, umkm_foto, umkm_deskripsi) values ({},{},'{}','{}','{}','{}','{}')""".format(u.user_id,u.pemilik_id,u.umkm_nama,u.umkm_kategori,u.umkm_alamat,u.umkm_foto,u.umkm_deskripsi))
        con.commit()
    except:
        return ({"status":"Error saat menambahkan umkm"})   
    finally:
        con.close()
    return {"status":"Berhasil menambahkan umkm"}

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
		create_table = """ CREATE TABLE proyek(
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
		create_table = """ CREATE TABLE tagihan(
				tagihan_id          INTEGER PRIMARY KEY AUTOINCREMENT,
				umkm_id             INTEGER NOT NULL,
				tagihan_status      INTEGER NOT NULL,
				tagihan_nilai       INTEGER NOT NULL,
				tagihan_tgl         TEXT    NOT NULL,
                FOREIGGN KEY (umkm_id) REFERENCES umkm (umkm_id)
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
		create_table = """ CREATE TABLE investasi(
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
