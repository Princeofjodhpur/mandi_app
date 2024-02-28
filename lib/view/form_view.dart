import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/utils/isar_provider.dart';

class SaleFormView extends StatefulWidget {
  const SaleFormView({super.key});

  @override
  State<SaleFormView> createState() => _SaleFormViewState();
}

class _SaleFormViewState extends State<SaleFormView> {
  List<FocusNode> focusNodes = List.generate(36, (_) => FocusNode());
  final GlobalKey _dropdownKey = GlobalKey();

  final isar = IsarProvider.isar;
  final _formKey = GlobalKey<FormState>();
  SaleModel saleModel = SaleModel();
  SaleModel? lastRecord; // To get last record entered in database
  var _dropdownValue;
  bool checkInputValid = true;

  final citiesSelected = TextEditingController();
  String selectedCity = '';
  // Auto Suggestion List
  List<String> itemNameList = [];
  List<String> supplierNameList = [];
  List<String> farmerNameList = [];
  List<String> customerNameList = [];

  // Constants
  static const String initialValueZero = '';

  // Extracted method for saving to the database
  Future<void> saveToDatabase(SaleModel saleModel) async {
    await isar.writeTxn(() async {
      await isar.saleModels.put(saleModel);
      resetForm();
    });
  }

  // Extracted method for saving and resetting the form
  void saveAndResetForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      calculation();

      focusNodes[0].requestFocus();
    }
  }

  void calculation(){
    bool isCal = false;
    double grossWeight = 0; // GrossWeight = w1+w2+w3.....+wN
    double cut = 0;
    saleModel.w.forEach((element) {
      if(element != 0){
        isCal = true;
      }
    });
    cut = saleModel.lot;
    saleModel.cut = cut.toString();

    if(isCal){
      //GrossWeight Calculation
      for (int i = 0;i< saleModel.w.length;i++){
        grossWeight = grossWeight + saleModel.w[i];
      }
      saleModel.grossWeight = grossWeight;
      //Net Weight Calculation
      saleModel.netWeight = grossWeight - (saleModel.customerNug * cut); // NetWeight = GrossWeight - (C.Nug * Cut)
      //Average Weight
      saleModel.avgWeight = (saleModel.netWeight/saleModel.customerNug) * saleModel.sellerNug;
    }

    //Basic and bikri Amount Claculation
    if(grossWeight == 0){
      saleModel.basicAmt = saleModel.customerNug * saleModel.customerRate;
      saleModel.bikriAmt = saleModel.sellerNug * saleModel.sellerRate;
    }else{
      saleModel.basicAmt = saleModel.netWeight * saleModel.customerRate;
      saleModel.bikriAmt = saleModel.avgWeight * saleModel.sellerRate;
    }
    saveToDatabase(saleModel);
  }

  // Extracted method for resetting the form
  Future<void> resetForm() async {
    lastRecord = null;
    saleModel = SaleModel();
    readfromDatabase();
    setState(() {});
    showSnackBar("Form Successfully Sumbitted");
    _formKey.currentState!.reset();
  }

  // Extracted method for showing a snackbar
  void showSnackBar(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        width: 230.0,
      ),
    );
  }

  //TextEditingControllers
  TextEditingController itemNameController = TextEditingController();
  TextEditingController supllierNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController farmerNameController = TextEditingController();
  TextEditingController srnoController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readfromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return lastRecord == null? Container() :RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if ((event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
                event.isKeyPressed(LogicalKeyboardKey.controlRight)) &&
            event.isKeyPressed(LogicalKeyboardKey.keyS)) {
          saveAndResetForm();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sale Form View'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CallbackShortcuts(
            bindings: <ShortcutActivator, VoidCallback>{
              const SingleActivator(LogicalKeyboardKey.enter): () {},
              const SingleActivator(LogicalKeyboardKey.tab): () {},
            },
            child: Form(
              key: _formKey,
              child: Focus(
                onKey: (focusNode, event) {
                    if (event.runtimeType == RawKeyUpEvent && event.logicalKey == LogicalKeyboardKey.enter ) {
                      focusNode.nextFocus();
                      setState(() {

                      });
                      return KeyEventResult.handled;
                    } if (event.runtimeType == RawKeyUpEvent && event.logicalKey == LogicalKeyboardKey.tab ) {
                      focusNode.nextFocus();
                      setState(() {});
                      return KeyEventResult.handled;
                    }

                  return KeyEventResult.ignored;
                },
                child: ListView(
                  children: [
                    buildRow([
                      TextFormField(
                        onTap: (){
                          focusNodes[0].requestFocus();
                          setState(() {

                          });
                        },
                        focusNode: focusNodes[0],
                        controller: srnoController,
                        decoration: InputDecoration(
                          filled: focusNodes[0].hasFocus? true : false,
                          fillColor: focusNodes[0].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                          labelText: 'Serial Number',
                          border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                        ),
                        validator: (value) {
                          if (r'^[0-9]+$' == 'null') {
                            if (value?.trim() == '') {
                              return null;
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                              return 'Please Enter Current Input';
                            } else {
                              return null;
                            }
                          }
                          if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please Enter Current Input';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          int? parsedValue = int.tryParse(value!);
                          saleModel.srNo = parsedValue!;
                        },
                      ),
                      RawAutocomplete<String>(
                        focusNode: focusNodes[1],
                        textEditingController: supllierNameController,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return supplierNameList;
                          } else {
                            List<String> matches = <String>[];
                            matches.addAll(supplierNameList);
                            matches.retainWhere((s) {
                              return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          setState(() {
                            saleModel.supplierName = selection;
                          });
                        },
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                            ) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: textEditingController,
                            onTap: (){
                              focusNodes[1].requestFocus();
                              setState(() {

                              });
                            },
                            decoration: InputDecoration(
                              filled: focusNodes[1].hasFocus? true : false,
                              fillColor: focusNodes[1].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                              labelText: 'Supplier Name',
                              border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                            ),
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            onChanged: (newValue) {
                              saleModel.supplierName = newValue;
                              selectedIndex = -1; // Reset selection when the text changes
                            },
                            validator: (value) {
                              String reg = r'^[a-z A-Z0-9]+$';
                              if (value!.isEmpty || !RegExp(reg).hasMatch(value)) {
                                return 'Please Enter Correct Input';
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options,
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                        tileColor: selectedIndex == index
                                            ? Colors.grey[100]
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      RawAutocomplete<String>(
                        focusNode: focusNodes[2],
                        textEditingController: farmerNameController,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return farmerNameList;
                          } else {
                            List<String> matches = <String>[];
                            matches.addAll(farmerNameList);
                            matches.retainWhere((s) {
                              return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          setState(() {
                            saleModel.farmerName = selection;
                          });
                        },
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                            ) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: textEditingController,
                            onTap: (){
                              focusNodes[2].requestFocus();
                              setState(() {

                              });
                            },
                            decoration: InputDecoration(
                              filled: focusNodes[2].hasFocus? true : false,
                              fillColor: focusNodes[2].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                              labelText: 'Farmer Name',
                              border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                            ),
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            onChanged: (newValue) {
                              saleModel.farmerName = newValue;
                            },
                            validator: (value) {
                              String reg = r'^[a-z A-Z0-9]+$';
                              if (reg == 'null') {
                                if (value?.trim() == '') {
                                  return null;
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                                  return 'Please Enter Correct Input';
                                } else {
                                  return null;
                                }
                              }
                              if (value!.isEmpty || !RegExp(reg).hasMatch(value)) {
                                return 'Please Enter Correct Input';
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options,
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ]),
                    buildRow([
                      buildDropMenu(),
                      // buildTextFormField('Lot', r'^[0-9]+$',
                      //     'Please Enter Current Input', TextInputType.number,
                      //     initialValue: initialValueZero,
                      //     onSaved: (value) =>
                      //         saleModel.lot = int.parse(value!)),
                      buildTextFormField('Nug (S.Nug/C.Nug)', r'^[0-9]+$',
                        'Please Enter Current Input', TextInputType.number,
                        initialValue: initialValueZero, onSaved: (value) {
                          saleModel.sellerNug = int.parse(value!);
                          saleModel.customerNug = int.parse(value);
                        },focus: focusNodes[4],isShow: focusNodes[4].hasFocus ? true : false),
                      RawAutocomplete<String>(
                        focusNode: focusNodes[5],
                        textEditingController: customerNameController,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return customerNameList;
                          } else {
                            List<String> matches = <String>[];
                            matches.addAll(customerNameList);
                            matches.retainWhere((s) {
                              return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          setState(() {
                            saleModel.customerName = selection;

                          });
                        },
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                            ) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: textEditingController,
                            onTap: (){
                              focusNodes[5].requestFocus();
                              setState(() {

                              });
                            },
                            decoration: InputDecoration(
                              filled: focusNodes[5].hasFocus? true : false,
                              fillColor: focusNodes[5].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                              labelText: 'Customer Name',
                              border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                            ),
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            onChanged: (newValue) {
                              saleModel.customerName = newValue;
                            },
                            validator: (value) {
                              String reg = r'^[a-z A-Z0-9]+$';
                              if (reg == 'null') {
                                if (value?.trim() == '') {
                                  return null;
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                                  return 'Please Enter Correct Input';
                                } else {
                                  return null;
                                }
                              }
                              if (value!.isEmpty || !RegExp(reg).hasMatch(value)) {
                                return 'Please Enter Correct Input';
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options,
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ]),
                    buildDynamicRow('W', 24, TextInputType.number),
                    buildRow([
                      RawAutocomplete<String>(
                        focusNode: focusNodes[6],
                        textEditingController: itemNameController,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return itemNameList;
                          } else {
                            List<String> matches = <String>[];
                            matches.addAll(itemNameList);
                            matches.retainWhere((s) {
                              return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          setState(() {
                            saleModel.itemName = selection;

                          });
                        },
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                            ) {
                          return TextFormField(
                            onTap: (){
                              focusNodes[6].requestFocus();
                              setState(() {

                              });
                            },
                            keyboardType: TextInputType.text,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              filled: focusNodes[6].hasFocus? true : false,
                              fillColor: focusNodes[6].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                              labelText: 'Item Name',
                              border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                            ),
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            onChanged: (newValue) {
                              saleModel.itemName = newValue;
                            },
                            validator: (value) {
                              String reg = r'^[a-z A-Z0-9]+$';
                              if (reg == 'null') {
                                if (value?.trim() == '') {
                                  return null;
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                                  return 'Please Enter Correct Input';
                                } else {
                                  return null;
                                }
                              }
                              if (value!.isEmpty || !RegExp(reg).hasMatch(value)) {
                                return 'Please Enter Correct Input';
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options,
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      TextFormField(
                        focusNode: focusNodes[7],
                        controller: dateController,
                        onTap: () async {
                          DateTime? tillDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().day - 1),
                              lastDate: DateTime.now());
                          if (tillDate != null) {
                            dateController.text = DateFormat('yyyy-MM-dd').format(tillDate);
                          }
                          focusNodes[7].requestFocus();
                          setState(() {});
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: focusNodes[7].hasFocus? true : false,
                          fillColor: focusNodes[7].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
                          labelText: 'Creation Date',
                          border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                        ),
                        validator: (value) {
                            if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value!)) {
                              return 'Please Enter Date in dd-MM-yyyy Format';
                            } else {
                              return null;
                            }
                        },
                        keyboardType: TextInputType.datetime,
                        onSaved: (value) {
                          saleModel.creationDate = DateTime.parse(value!);
                        },
                      ),
                      buildTextFormField('VCL No', r'^(.*)+$',
                          'Please Enter Current Input', TextInputType.text,
                          onSaved: (value) => saleModel.vclNo = value!,initialValue: lastRecord!.vclNo,focus: focusNodes[8],isShow: focusNodes[8].hasFocus ? true : false),
                    ],),
                    buildRow([
                      buildTextFormField('Freight Rate', r'^-?[0-9]+(\.[0-9]+)?$',
                          'Please Enter Current Input', TextInputType.number,
                          initialValue: lastRecord!.frightRate != 0.0? lastRecord!.frightRate.toString():"",
                          onSaved: (value) => saleModel.frightRate = double.parse(value!),focus: focusNodes[9],isShow: focusNodes[9].hasFocus ? true : false),
                      buildTextFormField('Other Charges', r'^-?[0-9]+(\.[0-9]+)?$',
                          'Please Enter Current Input', TextInputType.number,
                          initialValue: lastRecord!.otherCharges != 0.0? lastRecord!.otherCharges.toString():"",
                          onSaved: (value) => saleModel.otherCharges = double.parse(value!),focus: focusNodes[10],isShow: focusNodes[10].hasFocus ? true : false),
                      buildTextFormField('Labour Rate',r'^-?[0-9]+(\.[0-9]+)?$',
                          'Please Enter Current Input', TextInputType.number,
                          initialValue: lastRecord!.labourRate != 0.0 ? lastRecord!.labourRate.toString():"",
                          onSaved: (value) => saleModel.labourRate = double.parse(value!),focus: focusNodes[11],isShow: focusNodes[11].hasFocus ? true : false),
                    ]),
                    /*buildRow([
                      buildTextFormField('Seller Rate', r'^[0-9]+$',
                          'Please Enter Current Input', TextInputType.number,
                          initialValue: initialValueZero,
                          onSaved: (value) =>
                              saleModel.sellerRate = double.parse(value!)),
                      buildTextFormField('Customer Rate', r'^[0-9]+$',
                          'Please Enter Current Input', TextInputType.number,
                          initialValue: initialValueZero,
                          onSaved: (value) => saleModel.customerRate = double.parse(value!)),
                    ]),*/
                    // buildRow([
                    //   buildTextFormField('Gross Weight', r'^[0-9]+$',
                    //       'Please Enter Current Input', TextInputType.number,
                    //       initialValue: initialValueZero,
                    //       onSaved: (value) =>
                    //           saleModel.grossWeight = double.parse(value!)),
                    //   buildTextFormField('Net Weight', r'^[0-9]+$',
                    //       'Please Enter Current Input', TextInputType.number,
                    //       initialValue: initialValueZero,
                    //       onSaved: (value) =>
                    //           saleModel.netWeight = double.parse(value!)),
                    //   buildTextFormField('Avg Weight', r'^[0-9]+$',
                    //       'Please Enter Current Input', TextInputType.number,
                    //       initialValue: initialValueZero,
                    //       onSaved: (value) =>
                    //           saleModel.avgWeight = double.parse(value!)),
                    // ]),
                    // Example of dynamic TextFormField generation
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            saveAndResetForm();
          },
          tooltip: 'CTRL + S',
          child: const Icon(Icons.save_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  // Extracted method for building a row of text form fields
  Widget buildRow(List<Widget> children) {
    return Row(
      children: children
          .map((child) => Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                ),
              ))
          .toList(),
    );
  }

  // Extracted method for building a text form field
  Widget buildTextFormField(String labelText, String reg, String regReturn,
      TextInputType keyboardType, {String initialValue = '',
      required void Function(String?) onSaved,
      FocusNode? focus,bool isShow = false}) {

    return TextFormField(
      initialValue: initialValue,
      focusNode: focus,
      onTap: (){
        focus!.requestFocus();
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: isShow ? true : false,
        fillColor: isShow ? Color(0xffF0FFFF): Colors.transparent,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
      ),
        validator: (value) {
        if (reg == 'null') {

          if (value?.trim() == '') {
            return null;
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
            return regReturn;
          } else {
            return null;
          }
        }
        if (value!.isEmpty || !RegExp(reg).hasMatch(value)) {
          return regReturn;
        } else {
          return null;
        }
      },
      keyboardType: keyboardType,
      onSaved: onSaved,
    );
  }

  Widget buildDropMenu() {
    void dropdownCallback(String? selectedValue) {
      if (selectedValue is String) {
        setState(() {
          _dropdownValue = selectedValue;
        });
      }
    }

    return SizedBox(
      width: 100,
      // decoration: const ShapeDecoration(
      //     color: Colors.white,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(8)),
      //       side: BorderSide(width: 1.0, color: Colors.grey),
      //     )),
      child: Center(
        child: DropdownButtonFormField<String>(
          focusNode: focusNodes[3],
            onTap: (){
              focusNodes[3].requestFocus();
              setState(() {

              });
            },
            key: _dropdownKey,
            items: const [
              DropdownMenuItem(
                value: "3",
                child: Text('Peti'),
              ),
              DropdownMenuItem(
                value: "0.5",
                child: Text('Daba'),
              ),
              DropdownMenuItem(
                value: "1.25",
                child: Text('Box'),
              ),
              DropdownMenuItem(
                value: "0.25",
                child: Text('Plate'),
              ),
            ],
            // underline: const SizedBox(),
            borderRadius: BorderRadius.circular(8),
            decoration: InputDecoration(
              filled: focusNodes[3].hasFocus? true : false,
              fillColor: focusNodes[3].hasFocus? Color(0xffF0FFFF) : Colors.transparent,
              border: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                          ),
            value: _dropdownValue,
            onChanged: dropdownCallback,
            onSaved: (value) {
              saleModel.lot = double.parse(value!);
            }),
      ),
    );
  }

  // Example of dynamically generating text form fields based on a count
  Widget buildDynamicRow(String labelPrefix, int count, TextInputType keyboardType) {
    int i = 11;

    return Wrap(
      children: List.generate(
        count,
        (index) {
          i++;
          return SizedBox(
          width: 100.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildTextFormField(
                '$labelPrefix${index + 1}',
                'null'
                //r'^ ( [0-9] {3})?+$'
                ,
                'do not enter',
                keyboardType,
                initialValue: '',
                onSaved: (value) {
                  if (value != null && value!="") {
                    saleModel.w[index] = int.parse(value);
                  } else {
                    saleModel.w[index] = 0;
                  }
            },focus: focusNodes[i],isShow: focusNodes[i].hasFocus ? true : false),
          ),
        );
        },
      ),
    );
  }

  //Function to get last record value
  Future<void> readfromDatabase() async {
    itemNameList.clear();
    supplierNameList.clear();
    farmerNameList.clear();
    customerNameList.clear();
    Map<String, List<SaleModel>> itemNameListMap = {};
    Map<String, List<SaleModel>> supplierNameListMap = {};
    Map<String, List<SaleModel>> farmerNameListMap = {};
    Map<String, List<SaleModel>> customerNameListMap = {};


    var record = await isar.saleModels.where().findAll();
    if(record.isNotEmpty){
      record.forEach((task) {
        if (!itemNameListMap.containsKey(task.itemName)) {
          itemNameListMap[task.itemName] = [];
        }
        if (!supplierNameListMap.containsKey(task.supplierName)) {
          supplierNameListMap[task.supplierName] = [];
        }
        if (!farmerNameListMap.containsKey(task.farmerName)) {
          farmerNameListMap[task.farmerName] = [];
        }
        if (!farmerNameListMap.containsKey(task.customerName)) {
          customerNameListMap[task.customerName] = [];
        }
        itemNameListMap[task.itemName]!.add(task);
        supplierNameListMap[task.supplierName]!.add(task);
        farmerNameListMap[task.farmerName]!.add(task);
        customerNameListMap[task.customerName]!.add(task);
      });

      itemNameListMap.forEach((key, value) {
        if(key != "")
        itemNameList.add('$key');
      });
      supplierNameListMap.forEach((key, value) {
        if(key != "")
        supplierNameList.add('$key');
      });
      farmerNameListMap.forEach((key, value) {
        if(key != "")
        farmerNameList.add('$key');
      });
      customerNameListMap.forEach((key, value) {
        if(key != "")
        customerNameList.add('$key');
      });

      lastRecord = record.last;
      srnoController.text = (lastRecord!.srNo + 1).toString(); // Serial number calculation

      itemNameController.text = lastRecord!.itemName;
      dateController.text = lastRecord!.creationDate.toString().substring(0,10);
      supllierNameController.text = lastRecord!.supplierName;
      farmerNameController.text = lastRecord!.farmerName;
      saleModel.supplierName = lastRecord!.supplierName;
      saleModel.itemName = lastRecord!.itemName;
      saleModel.farmerName = lastRecord!.farmerName;
    }else{
      lastRecord = SaleModel();
    }


    setState(() {});
  }
}
