import 'dart:io';
import 'dart:isolate';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tubes/pages/borrower/borrower.dart';

enum genderType { male, female }

class BorrowerFundingPage extends StatefulWidget {
  const BorrowerFundingPage({super.key});

  @override
  State<BorrowerFundingPage> createState() => _BorrowerFundingPageState();
}

class _BorrowerFundingPageState extends State<BorrowerFundingPage> {
  int currentStep = 0;

  //data diri
  genderType? jenisGender;
  final namaLengkap = TextEditingController();
  final nik = TextEditingController();
  final ttl = TextEditingController();
  final alamat = TextEditingController();
  final pekerjaan = TextEditingController();

  String _jenisGender = "";
  String _namaLengkap = "";
  String _nik = "";
  String _ttl = "";
  String _alamat = "";
  String _pekerjaan = "";

  //detail usaha
  final namaUsaha = TextEditingController();
  final alamatUsaha = TextEditingController();
  String selectedKategori = "";

  String _namaUsaha = "";
  String _kategoriUsaha = "";
  String _alamatUsaha = "";

  List<String> usaha = [
    "Perdagangan dan Ritel",
    "Jasa Konsumen",
    "Kuliner",
    "Kreatif dan Seni",
    "Manufaktur dan Produksi",
    "Jasa Profesional",
    "Teknologi Informasi",
    "Pariwisata dan Penginapan",
    "Pertanian dan Agrobisnis",
    "Pendidikan dan Pelatihan",
  ];

  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  //Pendanaan
  final targetPendanaan = TextEditingController();
  final deskripsiPendanaan = TextEditingController();

  String _targetPendanaan = "";
  String _deskripsiPendanaan = "";
  String _batasWaktuPendanaan = "";

  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != DateTime.now()) {
      setState(
        () {
          _selectedDate = picked;
          _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
        },
      );
    }
  }

  //konfirmasi
  bool isKonfirmasi = false;

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(""),
          content: Column(
            children: [
              Center(
                child: Text(
                  "Data diri",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: namaLengkap,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Nama Anda",
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: nik,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan NIK Anda",
                  labelText: "Nomor Induk Kependudukan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ttl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Tempat, Tanggal Lahir",
                  labelText: "Tempat, Tanggal Lahir",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: alamat,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Alamat Anda",
                  labelText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: pekerjaan,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Pekerjaan Anda",
                  labelText: "Pekerjaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: jenisGender == genderType.male ? 2 : 1,
                              color: jenisGender == genderType.male
                                  ? Color.fromARGB(255, 0, 97, 175)
                                  : Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: genderType.male,
                                groupValue: jenisGender,
                                activeColor: Color.fromARGB(255, 0, 97, 175),
                                onChanged: (genderType? value) {
                                  setState(
                                    () {
                                      jenisGender = value;
                                      _jenisGender = 'Laki-laki';
                                    },
                                  );
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Laki-laki',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: jenisGender == genderType.male
                                        ? Color.fromARGB(255, 0, 97, 175)
                                        : Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: jenisGender == genderType.female ? 2 : 1,
                              color: jenisGender == genderType.female
                                  ? Color.fromARGB(255, 0, 97, 175)
                                  : Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: genderType.female,
                                groupValue: jenisGender,
                                activeColor: Color.fromARGB(255, 0, 97, 175),
                                onChanged: (genderType? value) {
                                  setState(
                                    () {
                                      jenisGender = value;
                                      _jenisGender = 'Perempuan';
                                    },
                                  );
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Perempuan',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: jenisGender == genderType.female
                                        ? Color.fromARGB(255, 0, 97, 175)
                                        : Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(""),
          content: Column(
            children: [
              Center(
                child: Text(
                  "Data diri",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: namaUsaha,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Nama Usaha Anda",
                  labelText: "Nama Usaha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 47.0,
                child: DropdownSearch<String>(
                  onChanged: (value) {
                    setState(
                      () {
                        selectedKategori = value!;
                      },
                    );
                  },
                  mode: Mode.DIALOG,
                  showSelectedItem: true,
                  items: usaha,
                  label: "Pilih Kategori Usaha",
                  hint: "Pilih Kategori",
                  showSearchBox: true,
                  showClearButton: true,
                  popupTitle: Container(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      "Pilih Kategori Usaha",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  popupShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  popupItemBuilder: (context, item, isSelected) {
                    return Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 230, 230, 230),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        item,
                        textAlign: TextAlign.left,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: alamatUsaha,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Alamat Usaha",
                  labelText: "Alamat Usaha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text(""),
          content: Column(
            children: [
              Center(
                child: Text(
                  "Foto",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Foto Usaha",
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Masukkan Foto Usaha",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    image != null
                        ? Container(
                            margin: EdgeInsets.all(10),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ))
                        : Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 30,
                                ),
                                height: 220,
                              ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          await getImage();
                        },
                        child: Text(
                          "Upload Foto",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text(""),
          content: Column(
            children: [
              Text(
                "Pendanaan",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: targetPendanaan,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Target Pendanaan (Rp)",
                  labelText: "Target Pendanaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Batas Waktu Pendanaan",
                  labelText: "Batas Waktu Pendanaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: deskripsiPendanaan,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  hintText: "Masukkan Deskripsi Pendanaan",
                  labelText: "Deskripsi Pendanaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 97, 175),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 4,
          title: Text(""),
          content: Column(
            children: [
              Text(
                "Konfirmasi",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Data diri",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Nama Lengkap",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_namaLengkap}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "NIK",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_nik}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "TTL",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_ttl}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Alamat",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_alamat}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Pekerjaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_pekerjaan}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_jenisGender}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Detail Usaha",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Nama Usaha",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_namaUsaha}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Kategori Usaha",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_kategoriUsaha}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Alamat Usaha",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_alamatUsaha}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Pendanaan",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Jumlah Target Pendanaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_targetPendanaan}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Batas Waktu Pendanaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_batasWaktuPendanaan}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          "Deskripsi Pendanaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          textAlign: TextAlign.right,
                          "${_deskripsiPendanaan}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengajuan Pendanaan",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 0, 97, 175),
          ),
        ),
        child: Stepper(
            type: StepperType.horizontal,
            elevation: 0,
            steps: getSteps(),
            currentStep: currentStep,
            onStepTapped: (step) => setState(
                  () {
                    currentStep = step;
                  },
                ),
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Pengajuan Berhasil Diajukan',
                  confirmBtnColor: Color.fromARGB(255, 0, 97, 175),
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BorrowerPage();
                        },
                      ),
                    );
                  },
                );
                setState(() => isKonfirmasi = true);
                print('Completed');
              } else {
                setState(() => currentStep += 1);
                setState(
                  () {
                    //akses text data diri
                    _namaLengkap = namaLengkap.text;
                    _nik = nik.text;
                    _ttl = ttl.text;
                    _alamat = alamat.text;
                    _pekerjaan = pekerjaan.text;

                    //akses text detail usaha
                    _namaUsaha = namaUsaha.text;
                    _alamatUsaha = alamatUsaha.text;
                    _kategoriUsaha = selectedKategori;

                    //akses text pendanaan usaha
                    _targetPendanaan = targetPendanaan.text;
                    _batasWaktuPendanaan = _dateController.text;
                    _deskripsiPendanaan = deskripsiPendanaan.text;
                  },
                );
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(
                      () => currentStep -= 1,
                    ),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          isLastStep ? 'Confirm' : 'Next',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: details.onStepCancel,
                          child: Text('Back'),
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

// class ConfirmationSent extends StatefulWidget {
//   const ConfirmationSent({super.key});

//   @override
//   State<ConfirmationSent> createState() => _ConfirmationSentState();
// }

// class _ConfirmationSentState extends State<ConfirmationSent> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [

//         ],
//       ),
//     );
//   }
// }
