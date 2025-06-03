class ApiEndPoints {
  static const String baseUrl = 'http://103.184.181.9/apiLaundry/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'loginkios';
  final String categories = 'categories';
  final String services = 'services';
  final String customers = 'getcustomerlist';
  final String saveTransaction = 'savetransaction';
  final String getListTransaction = 'getlisttransaction';
  final String getRowTransaction = 'getrowtransaction';
  final String getDetailTransaction = 'getdetailtransaction';
  final String updateStatus = 'updatestatus';
  final String transactionHistoryByMonth = 'transactionhistorybymonth';
  final String transactionHistoryByDateRange = 'transactionhistorybydaterange';
}
