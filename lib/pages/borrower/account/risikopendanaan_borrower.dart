import 'package:flutter/material.dart';

class RisikoPendanaanPage extends StatelessWidget {
  const RisikoPendanaanPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Risiko Pendanaan",
        ),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 97, 175, 1),
                Color.fromRGBO(18, 62, 99, 1),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: const Text(
              "Risiko Umum Pendanaan",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textAlign: TextAlign.justify,
              "Sebagaimana mendanai pada instrumen lainnya, terdapat risiko pendanaan pada peer-to-peer lending, yaitu risiko gagal bayar penerima pinjaman. Kami menyarankan calon pemberi pendanaan untuk mempelajari dan memahami risiko terkait dengan karakteristik pendanaan tersebut sehingga dapat melakukan pertimbangan dan membuat keputusan yang tepat. Berikut adalah risiko umum yang dihadapi oleh para Mitra Usaha kami.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
            child: Text(
              "Finansial",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              textAlign: TextAlign.justify,
              "Kesulitan membayar untuk pinjaman jangka panjang dikarenakan pendapatan yang tidak tetap. Mitra Usaha Amartha Tidak memiliki jaminan /agunan yang menyebabkan sulitnya mengetahui kelayakan pinjaman calon Mitra Usaha. Masih tidak memiliki akses ke institusi perbankan. Memiliki arus penghasilan tidak teratur / musiman. Rentan untuk perubahan bisnis bergantung musim dan lingkungan.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
            child: Text(
              "Faktor Internal",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              textAlign: TextAlign.justify,
              "Tidak memiliki bukti nyata untuk penilaian atas pendapatannya. Hilangnya kekompakan dalam kelompok/majelis ketika terjadi permasalahan pembayaran pada salah satu atau beberapa Mitra Usaha yang menyebabkan PAR. Keluarga sakit, kematian di keluarga inti terutama suami, perceraian yang menyebabkan hilangnya sumber pendapatan utama yang menyebabkan kesulitan membayar cicilan. Mengalami suatu keadaan yang menyebabkan Mitra Usaha lebih fokus untuk memenuhi kebutuhan pokok di rumah sehingga menyebabkan kesulitan membayar cicilan.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
            child: Text(
              "Pengetahuan",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              textAlign: TextAlign.justify,
              "Tidak mengetahui tentang usaha yang dijalankan sehingga mengalami kebangkrutan. Kurangnya pengetahuan tentang pasar, keuangan, dan kemampuan usaha yang menyebabkan kebangrutan serta kesulitan membayar cicilan. Usaha menurun disebabkan kompetisi dan keterlambatan ekonomi makro di Negara tersebut. Kebangkrutan terjadi karena buruknya penanganan ketika terjadi masalah pada usaha tersebutTidak mengetahui tentang usaha yang dijalankan sehingga mengalami kebangkrutan. Kurangnya pengetahuan tentang pasar, keuangan, dan kemampuan usaha yang menyebabkan kebangrutan serta kesulitan membayar cicilan. Usaha menurun disebabkan kompetisi dan keterlambatan ekonomi makro di Negara tersebut. Kebangkrutan terjadi karena buruknya penanganan ketika terjadi masalah pada usaha tersebut.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
            child: Text(
              "Musim",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              textAlign: TextAlign.justify,
              "Pengaruh musim yang menyebabkan tidak seimbangnya permintaan pasar dan ketersediaan barang, yang mempengaruhi alur dagang Mitra Usaha. Mitra usaha mempunyai beberapa usaha yang bergantung pada musim, sehingga menyebabkan tidak stabilnya pendapatan yang masuk dari hasil usaha tersebut. Bencana alam adalah salah satu faktor terbesar penyebab bangkrutnya usaha pertanian atau perternakan. Rentang waktu yang lama untuk bisa diperjual belikan membuat petani atau peternak menyebabkan tidak stabilnya pendapatan usaha per bulan.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
