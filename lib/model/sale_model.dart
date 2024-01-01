class SaleModel {
  // Identifiers
  int srNo;
  String itemName;

  // Supplier details
  String supplierName;
  String farmerName;
  String vclNo;

  // Date
  DateTime creationDate;

  // Weight details
  double grossWeight;
  double netWeight;
  double avgWeight;
  List<int> w; // w will be used to store all the values of w1, w2, w3,....,wn

  // Rate details
  double frightRate;
  double otherCharges;
  double labourRate;
  double sellerRate;
  double custormerRate;

  // Customer details
  String customerName;
  int customerNug; // cNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user

  // Other details
  int lot;
  int sellerNug; // sNug(sellerNug) will be copied from nug when the data is saved but can be changed by the user
  String cut; // cut is unit of nug E.g. Peti, Daba, Box, etc.

  // Constructor with initializer list
  SaleModel()
      : avgWeight = 0,
        customerName = '',
        customerNug = 0,
        custormerRate = 0,
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

  // Below is the code for the constructor with named parameters for later use
  // SaleModel({
  //   this.avgWeight = 0,
  //   this.customerName = '',
  //   this.customerNug = 0,
  //   this.custormerRate = 0,
  //   this.cut = '',
  //   this.creationDate,
  //   this.farmerName = '',
  //   this.frightRate = 0,
  //   this.grossWeight = 0,
  //   this.itemName = '',
  //   this.labourRate = 0,
  //   this.lot = 0,
  //   this.netWeight = 0,
  //   this.otherCharges = 0,
  //   this.sellerNug = 0,
  //   this.sellerRate = 0,
  //   this.srNo = 0,
  //   this.supplierName = '',
  //   this.vclNo = '',
  //   this.w,
  // }) {
  //   creationDate = Date ?? DateTime.now();
  //   w = w ?? List<int>.filled(10, 0);
  // }
}
