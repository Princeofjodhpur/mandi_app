import 'package:isar/isar.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'sale_model.g.dart';

@Collection()
class SaleModel {
  // Identifiers
  Id id = Isar.autoIncrement; // Annotated with late and required for Isar

  late int srNo;
  late String itemName;

  // Supplier details
  late String supplierName;
  late String farmerName;
  late String vclNo;

  // Date
  late DateTime creationDate;

  // Weight details
  late double grossWeight;
  late double netWeight;
  late double avgWeight;
  late List<int>
      w; // w will be used to store all the values of w1, w2, w3,....,wn

  // Rate details
  late double frightRate;
  late double otherCharges;
  late double labourRate;
  late double sellerRate;
  late double customerRate;

  // Customer details
  late String customerName;
  late int
      customerNug; // cNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user

  // Other details
  late int lot;
  late int
      sellerNug; // sNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user
  late String cut; // cut is the unit of nug E.g. Peti, Daba, Box, etc.

  // Constructor with initializer list
  SaleModel()
      : avgWeight = 0,
        customerName = '',
        customerNug = 0,
        customerRate = 0,
        cut = '',
        creationDate = DateTime.now(),
        farmerName = '',
        frightRate = 0,
        grossWeight = 0,
        itemName = '',
        labourRate = 0,
        lot = 0,
        netWeight = 0,
        otherCharges = 0,
        sellerNug = 0,
        sellerRate = 0,
        srNo = 0,
        supplierName = '',
        vclNo = '',
        w = List<int>.filled(10, 0);

  SaleModel.create({
    required this.srNo,
    required this.itemName,
    // Add other required fields here
  }) {
    id = 0; // You can set this to 0 or null, Isar will auto-generate it.
  }

  // Convert a PlutoRow to a SaleModel
  void fromPlutoRow(PlutoRow row) {
    // id = row.cells['id']?.value;
    // srNo = (row.cells['srNo']?.value != null) ? row.cells['srNo']?.value : 300,
    // itemName = row.cells['itemName']?.value;
    // supplierName = row.cells['supplierName']?.value;
    // farmerName = row.cells['farmerName']?.value;
    // vclNo = row.cells['vclNo']?.value;
    // creationDate = row.cells['creationDate']?.value;
    // grossWeight = row.cells['grossWeight']?.value;
    // netWeight = row.cells['netWeight']?.value;
    // avgWeight = row.cells['avgWeight']?.value;
    // w[0] = row.cells['w1']?.value;
    // frightRate = row.cells['frightRate']?.value;
    // otherCharges = row.cells['otherCharges']?.value;
    // labourRate = row.cells['labourRate']?.value;
    // sellerRate = row.cells['sellerRate']?.value;
    // customerRate = row.cells['customerRate']?.value;
    // customerName = row.cells['customerName']?.value;
    // customerNug = row.cells['customerNug']?.value;
    // lot = row.cells['lot']?.value;
    // sellerNug = row.cells['sellerNug']?.value;
    // cut = row.cells['cut']?.value;
  }

  // Convert a SaleModel to a PlutoRow
  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        // 'id': PlutoCell(value: id ?? 0),
        'srNo': PlutoCell(value: srNo),
        'itemName': PlutoCell(value: itemName),
        'supplierName': PlutoCell(value: supplierName),
        'farmerName': PlutoCell(value: farmerName),
        'vclNo': PlutoCell(value: vclNo),
        'creationDate': PlutoCell(value: creationDate),
        'grossWeight': PlutoCell(value: grossWeight),
        'netWeight': PlutoCell(value: netWeight),
        'avgWeight': PlutoCell(value: avgWeight),
        // 'w': PlutoCell(value: w ?? List<int>.filled(10, 0)),
        'frightRate': PlutoCell(value: frightRate),
        'otherCharges': PlutoCell(value: otherCharges),
        'labourRate': PlutoCell(value: labourRate),
        'sellerRate': PlutoCell(value: sellerRate),
        'customerRate': PlutoCell(value: customerRate),
        'customerName': PlutoCell(value: customerName),
        'customerNug': PlutoCell(value: customerNug),
        'lot': PlutoCell(value: lot),
        'sellerNug': PlutoCell(value: sellerNug),
        'cut': PlutoCell(value: cut),
      },
    );
  }
}

//Old Model
// class SaleModel {
//   // Identifiers
//   int srNo;
//   String itemName;

//   // Supplier details
//   String supplierName;
//   String farmerName;
//   String vclNo;

//   // Date
//   DateTime creationDate;

//   // Weight details
//   double grossWeight;
//   double netWeight;
//   double avgWeight;
//   List<int> w; // w will be used to store all the values of w1, w2, w3,....,wn

//   // Rate details
//   double frightRate;
//   double otherCharges;
//   double labourRate;
//   double sellerRate;
//   double custormerRate;

//   // Customer details
//   String customerName;
//   int customerNug; // cNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user

//   // Other details
//   int lot;
//   int sellerNug; // sNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user
//   String cut; // cut is unit of nug E.g. Peti, Daba, Box, etc.

//   // Constructor with initializer list
//   SaleModel()
//       : avgWeight = 0,
//         customerName = '',
//         customerNug = 0,
//         custormerRate = 0,
//         cut = '',
//         creationDate = DateTime.now(),
//         farmerName = '',
//         frightRate = 0,
//         grossWeight = 0,
//         itemName = '',
//         labourRate = 0,
//         lot = 0,
//         netWeight = 0,
//         otherCharges = 0,
//         sellerNug = 0,
//         sellerRate = 0,
//         srNo = 0,
//         supplierName = '',
//         vclNo = '',
//         w = List<int>.filled(10, 0);

//   // Below is the code for the constructor with named parameters for later use
//   // SaleModel({
//   //   this.avgWeight = 0,
//   //   this.customerName = '',
//   //   this.customerNug = 0,
//   //   this.custormerRate = 0,
//   //   this.cut = '',
//   //   this.creationDate,
//   //   this.farmerName = '',
//   //   this.frightRate = 0,
//   //   this.grossWeight = 0,
//   //   this.itemName = '',
//   //   this.labourRate = 0,
//   //   this.lot = 0,
//   //   this.netWeight = 0,
//   //   this.otherCharges = 0,
//   //   this.sellerNug = 0,
//   //   this.sellerRate = 0,
//   //   this.srNo = 0,
//   //   this.supplierName = '',
//   //   this.vclNo = '',
//   //   this.w,
//   // }) {
//   //   creationDate = Date ?? DateTime.now();
//   //   w = w ?? List<int>.filled(10, 0);
//   // }
// }

