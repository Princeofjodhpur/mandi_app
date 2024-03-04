import 'package:isar/isar.dart';
/*
import 'package:pluto_grid/pluto_grid.dart';
*/

part 'sale_model.g.dart';

@Collection()
class SaleModel {
  // Identifiers
  Id id = Isar.autoIncrement; // Annotated with late and required for Isar
  //Checkbox
  final bool? isSelected;

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
  late List<int> w; // w will be used to store all the values of w1, w2, w3,....,wn

  // Rate details
  late double frightRate;
  late double otherCharges;
  late double labourRate;
  late double sellerRate;
  late double customerRate;

  // Customer details
  late String customerName;
  late int customerNug; // cNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user

  // Other details
  late double lot;
  late int sellerNug; // sNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user
  late String cut; // cut is the unit of nug E.g. Peti, Daba, Box, etc.

  //Calculation Fields
  late double basicAmt;
  late double bikriAmt;

  // Constructor with initializer list
  SaleModel() : avgWeight = 0,
        isSelected = false,
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
        bikriAmt = 0,
        basicAmt = 0,
        srNo = 0,
        supplierName = '',
        vclNo = '',
        w = List<int>.filled(24, 0);

  SaleModel.create(this.isSelected, {
    required this.srNo,
    required this.itemName,
    this.supplierName = 'supplierName',
    // Add other required fields here
  }) {
    id = 0; // You can set this to 0 or null, Isar will auto-generate it.
  }

  // Convert a PlutoRow to a SaleModel
  /*void fromPlutoRow(PlutoRow row) {
    id = row.cells['id']?.value;
    srNo = row.cells['srNo']?.value;
    itemName = row.cells['itemName']?.value;
    supplierName = row.cells['supplierName']?.value;
    farmerName = row.cells['farmerName']?.value;
    vclNo = row.cells['vclNo']?.value;
    creationDate = DateTime.parse(row.cells['creationDate']?.value);
    grossWeight = double.parse(row.cells['grossWeight']!.value.toString());
    netWeight =
        double.tryParse(row.cells['netWeight']?.value?.toString() ?? '0.0')!;
    avgWeight =
        double.tryParse(row.cells['avgWeight']?.value?.toString() ?? '0.0')!;
    // w[0] = row.cells['w1']?.value;
    frightRate =
        double.tryParse(row.cells['frightRate']?.value?.toString() ?? '0.0')!;
    otherCharges =
        double.tryParse(row.cells['otherCharges']?.value?.toString() ?? '0.0')!;
    labourRate =
        double.tryParse(row.cells['labourRate']?.value?.toString() ?? '0.0')!;
    sellerRate =
        double.tryParse(row.cells['sellerRate']?.value?.toString() ?? '0.0')!;
    customerRate =
        double.tryParse(row.cells['customerRate']?.value?.toString() ?? '0.0')!;
    customerName = row.cells['customerName']?.value;
    customerNug = row.cells['customerNug']?.value;
    lot = row.cells['lot']?.value;
    sellerNug = row.cells['sellerNug']?.value;
    cut = row.cells['cut']?.value;
  }*/

  // Convert a SaleModel to a PlutoRow
  /*PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: id),
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
  }*/

  void updateField(String key, dynamic value) {
    switch (key) {
      case 'srNo':
        srNo = value as int;
        break;
      case 'itemName':
        itemName = value as String;
        break;
      case 'supplierName':
        supplierName = value as String;
        break;
      case 'farmerName':
        farmerName = value as String;
        break;
      case 'vclNo':
        vclNo = value as String;
        break;
      case 'creationDate':
        creationDate = DateTime.parse(value);
        break;
      case 'grossWeight':
        grossWeight = value as double;
        break;
      case 'netWeight':
        netWeight = value as double;
        break;
      case 'avgWeight':
        avgWeight = value as double;
        break;
      case 'w':
        w = value as List<int>;
        break;
      case 'frightRate':
        frightRate = value as double;
        break;
      case 'otherCharges':
        otherCharges = value as double;
        break;
      case 'labourRate':
        labourRate = value as double;
        break;
      case 'sellerRate':
        sellerRate = value as double;
        break;
      case 'customerRate':
        customerRate = value as double;
        break;
      case 'customerName':
        customerName = value as String;
        break;
      case 'customerNug':
        customerNug = value as int;
        break;
      case 'lot':
        lot = value as double;
        break;
      case 'sellerNug':
        sellerNug = value as int;
        break;
      case 'cut':
        cut = value as String;
        break;
      default:
        throw Exception('Invalid field: $key');
    }
  }
}
