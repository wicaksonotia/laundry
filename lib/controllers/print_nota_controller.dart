import 'package:laundry/models/transaction_model.dart';
import 'package:laundry/networks/api_request.dart';
import 'package:laundry/utils/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class PrintNotaController extends GetxController {
  var transactionDetailItems = <TransactionDetailModel>[].obs;

  /// ===================================
  /// PRINT TRANSACTION
  /// ===================================
  void printTransaction(int numerator, String kios) async {
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    List<int> nota = await printPurchaseOrder(numerator, kios);
    if (connectionStatus) {
      var resultPrint = await PrintBluetoothThermal.writeBytes(nota);
      if (!resultPrint) {
        Get.snackbar(
          'Notification',
          'Failed to print',
          icon: const Icon(Icons.error),
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      var macPrinterAddress = "10:22:33:C7:00:BA";
      PrintBluetoothThermal.pairedBluetooths.then((devices) {
        PrintBluetoothThermal.connect(
          macPrinterAddress: macPrinterAddress,
        ).then((connected) {
          if (!connected) {
            Get.snackbar(
              'Notification',
              'Failed to connect to printer',
              icon: const Icon(Icons.error),
              snackPosition: SnackPosition.TOP,
            );
          } else {
            PrintBluetoothThermal.writeBytes(nota).then((result) {
              if (!result) {
                Get.snackbar(
                  'Notification',
                  'Failed to print',
                  icon: const Icon(Icons.error),
                  snackPosition: SnackPosition.TOP,
                );
              }
            });
          }
        });
      });
    }
  }

  Future<List<int>> printPurchaseOrder(int numerator, String kios) async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();

    // IMAGE
    final ByteData data = await rootBundle.load('assets/images/logo.jpg');
    final Uint8List bytesImg = data.buffer.asUint8List();
    final image = decodeImage(bytesImg);
    final resizedImage = copyResize(image!, width: 300);
    bytes += generator.image(resizedImage);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kiosAddress = prefs.getString('alamat')?.replaceAll(r'\n', '\n');
    bytes += generator.text(
      '$kiosAddress',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.feed(1);

    var resultListTransaction =
        await RemoteDataSource.getListTransactionDetails(numerator, kios);
    var resultRowTransaction = await RemoteDataSource.getRowTransactionDetails(
      numerator,
      kios,
    );
    transactionDetailItems.assignAll(resultListTransaction!);
    // CART LIST
    for (var cartItem in transactionDetailItems) {
      bytes += generator.row([
        PosColumn(
          text: cartItem.productName ?? 'Unknown Product',
          width: 7,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: cartItem.quantity.toString(),
          width: 2,
          styles: const PosStyles(align: PosAlign.center),
        ),
        PosColumn(
          text:
              (CurrencyFormat.convertToIdr(cartItem.totalPrice, 0)).toString(),
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'Subtotal',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: CurrencyFormat.convertToIdr(
          transactionDetailItems
              .map((e) => e.totalPrice)
              .fold(0, (value, element) => value + element!),
          0,
        ),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Discount',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text:
            resultRowTransaction!.discount.toString() == '0'
                ? '0'
                : CurrencyFormat.convertToIdr(resultRowTransaction.discount, 0),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'Grand Total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: CurrencyFormat.convertToIdr(
          transactionDetailItems
                  .map((e) => e.totalPrice)
                  .fold(0, (value, element) => value + element!) -
              resultRowTransaction.discount!,
          0,
        ),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.feed(1);

    //barcode
    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.upcA(barData));

    //QR code
    bytes += generator.qrcode('https://www.instagram.com/esjeruk.kadiri/');
    bytes += generator.text(
      DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.feed(1);

    // IMAGE
    final ByteData _dataHastag = await rootBundle.load(
      'assets/images/hastag.jpg',
    );
    final Uint8List _bytesImgHastag = _dataHastag.buffer.asUint8List();
    final _imageHastag = decodeImage(_bytesImgHastag);
    final _resizedImageHastag = copyResize(_imageHastag!, width: 300);
    bytes += generator.image(_resizedImageHastag);

    bytes += generator.feed(2);
    // bytes += generator.cut();
    return bytes;
  }
}
