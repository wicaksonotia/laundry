List<Map<String, dynamic>> paymentCategory = [
  {"value": false, "nama": "Bayar Nanti"},
  {"value": true, "nama": "Bayar Sekarang"},
];

List<Map<String, String>> filterKategori = [
  {"value": "hari", "nama": "Date"},
  {"value": "bulan", "nama": "Month"},
  // {"value": "tahun", "nama": "Year"},
];

List<Map<String, String>> filterStatus = [
  {"value": "all", "nama": "Semua"},
  {"value": "waiting", "nama": "Masih Antri"},
  {"value": "proccess", "nama": "Proses"},
  {"value": "completed", "nama": "Selesai"},
  {"value": "delivered", "nama": "Sudah Diambil"},
];

List<Map<String, dynamic>> yaTidak = [
  {"value": true, "nama": "Ya"},
  {"value": false, "nama": "Tidak"},
];
