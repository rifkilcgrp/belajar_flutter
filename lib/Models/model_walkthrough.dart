class ModelWalkthrough {
  String? judul;
  String? deskripsi;
  String? gambar;

  ModelWalkthrough({this.judul, this.deskripsi, this.gambar});
}

List walkthoughList = [
  ModelWalkthrough(
      judul: 'Selamat Datang ',
      deskripsi: 'Rate yang bersaing',
      gambar: 'assets/img/get-money.png'),
  ModelWalkthrough(
      judul: 'Lokasi Akurat',
      deskripsi: 'Lokasi yang kami tampilkan akurat',
      gambar: 'assets/img/check-route-2.png'),
  ModelWalkthrough(
      judul: 'Terima Kasih Sudah Mendownload',
      deskripsi: 'Mulai',
      gambar: 'assets/img/order-download.png'),
];