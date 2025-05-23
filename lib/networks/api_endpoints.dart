class ApiEndPoints {
  static const String baseUrl = 'http://103.184.181.9/apiLaundry/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'loginkios';
  final String categories = 'categories';
  final String services = 'services';
  final String getRowTransactions = 'gettransaction';
  final String getTransactionDetails = 'transactiondetail';
  final String saveDetailTransaction = 'savedetailtransaction';
  final String saveTransaction = 'savetransaction';
}
