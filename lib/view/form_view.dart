import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> saveToDatabase(SaleModel saleModel) async {
    await isar.writeTxn(() async {
      await isar.saleModels.put(saleModel);
    });
  }

  void saveAndResetForm() {
    if (_formKey.currentState!.validate()) {
      // Save the form
      _formKey.currentState!.save();

      // Save to database
      saveToDatabase(saleModel);

      // Reset the form
      saleModel = SaleModel();
      _formKey.currentState!.reset();

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entry saved successfully!'),
          duration: Duration(milliseconds: 200),
          behavior: SnackBarBehavior.floating,
          width: 230.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: '0',
                            decoration: const InputDecoration(
                              labelText: 'Serial Number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              saleModel.srNo = int.parse(value!);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: 'item name',
                            decoration: const InputDecoration(
                              labelText: 'Item Name',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              saleModel.itemName = value!;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue:
                                DateTime.now().toString().substring(0, 10),
                            decoration: const InputDecoration(
                              labelText: 'Creation Date',
                              hintText: 'YYYY-MM-DD',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.datetime,
                            onSaved: (value) {
                              saleModel.creationDate = DateTime.parse(value!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: '0.0',
                            decoration: const InputDecoration(
                              labelText: 'Freight Rate',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              saleModel.frightRate = double.parse(value!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add TextFormField widgets for other fields

                  // DropdownButton for 'cut'
                  // DropdownButtonFormField<String>(
                  //   value: saleModel.cut,
                  //   items: ['Peti', 'Daba', 'Box'] // Add more options as needed
                  //       .map((cut) {
                  //     return DropdownMenuItem<String>(
                  //       value: cut,
                  //       child: Text(cut),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       saleModel.cut = value!;
                  //     });
                  //   },
                  // ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // Dynamically create TextFormField widgets for 'w'
                      // based on the user's choice
                      children: List.generate(
                        saleModel.w.length,
                        (index) => SizedBox(
                          width: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: '0',
                              clipBehavior: Clip.hardEdge,
                              decoration: InputDecoration(
                                labelText: 'w$index',
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                saleModel.w[index] = int.parse(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: saveAndResetForm,
          tooltip: 'CTRL + S',
          child: const Icon(Icons.save_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
