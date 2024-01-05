import 'package:flutter/material.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/utils/isar_provider.dart';

class SaleFormView extends StatefulWidget {
  const SaleFormView({Key? key}) : super(key: key);

  @override
  State<SaleFormView> createState() => _SaleFormViewState();
}

class _SaleFormViewState extends State<SaleFormView> {
  final isar = IsarProvider.isar;
  final _formKey = GlobalKey<FormState>();
  SaleModel saleModel = SaleModel();

  // Constants
  static const String initialValueZero = '0';
  static const String initialValueItemName = 'item name';

  // Extracted method for saving to the database
  Future<void> saveToDatabase(SaleModel saleModel) async {
    await isar.writeTxn(() async {
      await isar.saleModels.put(saleModel);
    });
  }

  // Extracted method for saving and resetting the form
  void saveAndResetForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      saveToDatabase(saleModel);
      resetForm();
      showSnackBar('Entry saved successfully!');
    }
  }

  // Extracted method for resetting the form
  void resetForm() {
    saleModel = SaleModel();
    _formKey.currentState!.reset();
  }

  // Extracted method for showing a snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 200),
        behavior: SnackBarBehavior.floating,
        width: 230.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Form View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow([
                    buildTextFormField('Serial Number', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) => saleModel.srNo = int.parse(value!)),
                    buildTextFormField('Item Name', TextInputType.text,
                        initialValue: initialValueItemName,
                        onSaved: (value) => saleModel.itemName = value!),
                    buildTextFormField('Creation Date', TextInputType.datetime,
                        initialValue:
                            DateTime.now().toString().substring(0, 10),
                        onSaved: (value) =>
                            saleModel.creationDate = DateTime.parse(value!)),
                  ]),
                  buildRow([
                    buildTextFormField('Freight Rate', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.frightRate = double.parse(value!)),
                    buildTextFormField('Other Charges', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.otherCharges = double.parse(value!)),
                  ]),
                  // Add more rows for other fields

                  // Example of dynamic TextFormField generation
                  buildDynamicRow('W', 4, TextInputType.number),

                  buildRow([
                    buildTextFormField('Lot', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) => saleModel.lot = int.parse(value!)),
                    buildTextFormField(
                        'Nug (S.Nug/C.Nug)', TextInputType.number,
                        initialValue: initialValueZero, onSaved: (value) {
                      saleModel.sellerNug = int.parse(value!);
                      saleModel.customerNug = int.parse(value);
                    }),
                  ]),
                  buildRow([
                    buildTextFormField('Labour Rate', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.labourRate = double.parse(value!)),
                    buildTextFormField('Seller Rate', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.sellerRate = double.parse(value!)),
                    buildTextFormField('Customer Rate', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.customerRate = double.parse(value!)),
                  ]),
                  buildRow([
                    buildTextFormField('Gross Weight', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.grossWeight = double.parse(value!)),
                    buildTextFormField('Net Weight', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.netWeight = double.parse(value!)),
                    buildTextFormField('Avg Weight', TextInputType.number,
                        initialValue: initialValueZero,
                        onSaved: (value) =>
                            saleModel.avgWeight = double.parse(value!)),
                  ]),
                  buildRow([
                    buildTextFormField('Supplier Name', TextInputType.text,
                        onSaved: (value) => saleModel.supplierName = value!),
                    buildTextFormField('Farmer Name', TextInputType.text,
                        onSaved: (value) => saleModel.farmerName = value!),
                    buildTextFormField('VCL No', TextInputType.text,
                        onSaved: (value) => saleModel.vclNo = value!),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveAndResetForm,
        tooltip: 'CTRL + S',
        child: const Icon(Icons.save_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
  Widget buildTextFormField(String labelText, TextInputType keyboardType,
      {String initialValue = '', required void Function(String?) onSaved}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
    );
  }

  // Example of dynamically generating text form fields based on a count
  Widget buildDynamicRow(
      String labelPrefix, int count, TextInputType keyboardType) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          count,
          (index) => SizedBox(
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTextFormField(
                  '$labelPrefix${index + 1}', keyboardType,
                  initialValue: '0',
                  onSaved: (value) => saleModel.w[index] = int.parse(value!)),
            ),
          ),
        ),
      ),
    );
  }
}
