import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/utils/isar_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final GlobalKey<SfDataGridState> _dataGridKey = GlobalKey<SfDataGridState>();
bool? isHeaderCheckboxState = false;

class TabularView extends StatefulWidget {
  const TabularView({super.key});

  @override
  State<TabularView> createState() => _TabularViewState();
}

class _TabularViewState extends State<TabularView> {
  final DataGridController _dataGridController = DataGridController();
  final isar = IsarProvider.isar;

  List<SaleModel> saleModel = [];
  late _MyDataSource sale;
  List<SaleModel> data = [];
  List<String> vclArray = [];
  String selectedDate = "", selected_vcl_no = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    stateSetter(fn) {
      setState(fn);
    }
    selectedDate = DateTime.now().toString().substring(0,10); //to show today's date items
    sale = _MyDataSource([], _dataGridController, stateSetter);
  }

  void getData() async {
    saleModel.clear();
    final loadedData = await DataRepository().getSale();
    setState(() {});
    stateSetter(fn) {
      setState(fn);
    }
    loadedData.forEach((element) {
      if (selectedDate != "") {
        if (element.creationDate.toString().substring(0, 10) == selectedDate) {
          saleModel.add(element);
        }
      } else if (selected_vcl_no != "") {
        if (element.vclNo.toString() == selected_vcl_no) {
          saleModel.add(element);
        }
      } else {
        saleModel.add(element);
      }
    });
    sale = _MyDataSource(saleModel, _dataGridController, stateSetter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              List<DataGridRow> selectedRows = _dataGridController.selectedRows;
              if (selectedRows.isNotEmpty) {
                List<int> saleModelIds = _dataGridController.selectedRows
                    .map((row) => (row.getCells()[1].value as int))
                    .toList();
                await isar.writeTxn(() async {
                  for (int saleModelId in saleModelIds) {
                    await isar.saleModels.delete(saleModelId);
                  }
                });
              }
              stateSetter(fn) {
                setState(fn);
              }
              saleModel.clear();
              sale = _MyDataSource(saleModel, _dataGridController, stateSetter);
            },
            icon: const Icon(Icons.delete_rounded),
          ),
          IconButton(
            onPressed: () async {
              DateTime? tillDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 30),
                  lastDate: DateTime.now(),
                  initialEntryMode: DatePickerEntryMode.calendarOnly);

              if (tillDate != null) {
                //startingDate.text = datePicked.toString();
                selectedDate = DateFormat('yyyy-MM-dd').format(tillDate);
                stateSetter(fn) {
                  setState(fn);
                }


                saleModel.clear();
                sale = _MyDataSource(saleModel, _dataGridController, stateSetter);
              }
              setState(() {});
            },
            icon: const Icon(Icons.calendar_month),
          ),
          IconButton(
            onPressed: () async {
              vclArray.clear();
              vclArray.add("All");
              Future<Map<String, List<SaleModel>>> data = groupTasksByVehicle();
              data.then((result) {
                // Iterate over the map and print each entry
                result.forEach((vehicle, sales) {
                  vclArray.add(vehicle.toString());
                  setState(() {});
                });

                // dialog show after vehicle sorting
                showDialog(
                  context: context,
                  builder: (builder) {
                    return SimpleDialog(
                      title: const Text("Select Vehicle"),
                      children: List.generate(vclArray.length, (index) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            selected_vcl_no = vclArray[index];
                            if(vclArray[index] == "All"){ selectedDate = ""; selected_vcl_no = "";};
                            vclArray.clear();
                            stateSetter(fn) {
                              setState(fn);
                            }
                            saleModel.clear();
                            sale = _MyDataSource(
                                saleModel, _dataGridController, stateSetter);
                            setState(() {});
                          },
                          child: Text(vclArray[index]),
                        );
                      }),
                    );
                  },
                );
              });
              setState(() {});
            },
            icon: const Icon(Icons.emoji_transportation),
          ),
        ],
      ),
      body: FutureBuilder<List<SaleModel>>(
        future: isar.saleModels.where().findAll(),
        builder: (context, snapshot) {
          saleModel.clear();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            stateSetter(fn) {
              setState(fn);
            }
            snapshot.data!.forEach((element) {
               if (selected_vcl_no != "" && selectedDate != "") {
                if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                  saleModel.add(element);
                }
               }else if (selectedDate != "" || selected_vcl_no != "") {
                 if (element.creationDate.toString().substring(0, 10) == selectedDate) {
                   saleModel.add(element);
                 }else if(element.vclNo.toString() == selected_vcl_no){
                   saleModel.add(element);
                 }
               }else{
                 saleModel.add(element);
               }
            });
            sale = _MyDataSource(saleModel, _dataGridController, stateSetter);
            return sale.updatedData.isEmpty ?Center(child: Text("No record found"),) : SfDataGrid(
              source: sale,
              key: _dataGridKey,
              allowColumnsResizing: true,
              editingGestureType: EditingGestureType.tap,
              allowEditing: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              headerRowHeight: 50,
              rowHeight: 40,
              columns: <GridColumn>[
                GridColumn(
                  allowEditing: false,
                  columnName: 'CheckBox',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: Checkbox(
                      tristate: true,
                      value: isHeaderCheckboxState,
                      onChanged: (value) {
                        if (value == true && isHeaderCheckboxState == false) {
                          for (var element in sale.saleData) {
                            element.getCells()[0] = const DataGridCell<bool>(
                                columnName: 'CheckBox', value: true);
                          }
                          _dataGridController.selectedRows = sale.rows;
                          isHeaderCheckboxState = value;
                        } else if (value == null &&
                            isHeaderCheckboxState == true) {
                          for (var element in sale.saleData) {
                            element.getCells()[0] = const DataGridCell<bool>(
                                columnName: 'CheckBox', value: false);
                          }
                          _dataGridController.selectedRows = [];
                          isHeaderCheckboxState = false;
                        } else {
                          for (var element in sale.saleData) {
                            element.getCells()[0] = const DataGridCell<bool>(
                                columnName: 'CheckBox', value: true);
                          }
                          _dataGridController.selectedRows = sale.rows;
                          isHeaderCheckboxState = true;
                        }
                        // To update the datagrid rows.
                        sale.updateDataGrid();
                        // To update the datagrid view.
                        setState(() {});
                      },
                    ),
                  ),
                ),
                GridColumn(
                  visible: false,
                  allowEditing: false,
                  columnName: 'id',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Id',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'srNo',
                  label: Container(
                    alignment: Alignment.center,
                    color: Colors.grey[100],
                    child: const Text(
                      'Sr No',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'vclNo',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'VCL No',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'supplierName',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Supplier Name',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'farmerName',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Farmer Name',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'lot',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Lot',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'sellerNug',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'S. Nug',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'avgWeight',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Avg Weight',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'sellerRate',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Seller Rate',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'customerRate',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Customer Rate',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'customerName',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Customer Name',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'customerNug',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'C. Nug',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'netWeight',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Net Weight',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'itemName',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'ItemName',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  allowEditing: false,
                  columnName: 'grossWeight',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Gross Weight',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'frightRate',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Fright Rate',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'otherCharges',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Other Charges',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'labourRate',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Labour Rate',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  allowEditing: false,
                  columnName: 'cut',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Cut',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'weight',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Weights',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  allowEditing: false,
                  columnName: 'creationDate',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Creation Date',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  visible: false,
                  allowEditing: false,
                  columnName: 'basicAmt',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Basic Amount',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridColumn(
                  visible: false,
                  allowEditing: false,
                  columnName: 'bikriAmt',
                  label: Container(
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: const Text(
                      'Bikri Amount',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              controller: _dataGridController,
            );
          }
        },
      ),
    );
  }

  Future<Map<String, List<SaleModel>>> groupTasksByVehicle() async {
    var record = await isar.saleModels.where().findAll();
    Map<String, List<SaleModel>> groupedTasks = {};

    record.forEach((task) {
      if (!groupedTasks.containsKey(task.vclNo)) {
        groupedTasks[task.vclNo] = [];
      }
      groupedTasks[task.vclNo]!.add(task);
    });

    return groupedTasks;
  }
}

class _MyDataSource extends DataGridSource {
  /// Helps to hold the new value of all editable widgets.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on the onCellSubmit method.
  dynamic newCellValue;

  /// Helps to control the editable text in the [TextField] widget.
  TextEditingController editingController = TextEditingController();
  final StateSetter _setState;

  _MyDataSource(this.updatedData, this.dataGridController, this._setState) {
    // Helps to show data grid
    saleData = updatedData.map<DataGridRow>((e) {
      String w = "";
      e.w.forEach((element) {
        if (element != 0) {
          if (w == "") {
            w = element.toString();
          } else {
            w = "$w+$element";
          }
        }
      });
      return DataGridRow(cells: [
        DataGridCell<bool>(columnName: 'CheckBox', value: e.isSelected),
        DataGridCell<int>(columnName: 'id', value: e.id),
        DataGridCell<int>(columnName: 'srNo', value: e.srNo),
        DataGridCell<String>(columnName: 'vclNo', value: e.vclNo),
        DataGridCell<String>(columnName: 'supplierName', value: e.supplierName),
        DataGridCell<String>(columnName: 'farmerName', value: e.farmerName),
        DataGridCell<double>(columnName: 'lot', value: e.lot),
        DataGridCell<int>(columnName: 'sellerNug', value: e.sellerNug),
        DataGridCell<String>(
            columnName: 'avgWeight', value: e.avgWeight.toStringAsFixed(2)),
        DataGridCell<String>(
            columnName: 'sellerRate', value: e.sellerRate.toStringAsFixed(2)),
        DataGridCell<String>(
            columnName: 'customerRate',
            value: e.customerRate.toStringAsFixed(2)),
        DataGridCell<String>(columnName: 'customerName', value: e.customerName),
        DataGridCell<int>(columnName: 'customerNug', value: e.customerNug),
        DataGridCell<String>(
            columnName: 'netWeight', value: e.netWeight.toStringAsFixed(2)),
        DataGridCell<String>(columnName: 'itemName', value: e.itemName),
        DataGridCell<String>(
            columnName: 'grossWeight', value: e.grossWeight.toStringAsFixed(2)),
        DataGridCell<double>(columnName: 'frightRate', value: e.frightRate),
        DataGridCell<double>(columnName: 'otherCharges', value: e.otherCharges),
        DataGridCell<double>(columnName: 'labourRate', value: e.labourRate),
        DataGridCell<String>(columnName: 'cut', value: e.cut),
        DataGridCell<String>(columnName: 'weight', value: w),
        DataGridCell<DateTime>(
            columnName: 'creationDate', value: e.creationDate),
        DataGridCell<double>(columnName: 'basicAmt', value: e.basicAmt),
        DataGridCell<double>(columnName: 'bikriAmt', value: e.bikriAmt),
      ]);
    }).toList();
  }

  DataGridController dataGridController;
  List<DataGridRow> saleData = [];
  List<SaleModel> updatedData = [];

  @override
  List<DataGridRow> get rows => saleData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      int index = effectiveRows.indexOf(row);
      Color color = index.isOdd ? Colors.grey[100]! : Colors.white;
      var lotValue;
      if(e.columnName == "lot"){
        if(e.value == 0.25){
          lotValue = "Plate";
        }else if(e.value == 1.25){
          lotValue = "Box";
        }else if(e.value == 0.5){
          lotValue = "Daba";
        }else if(e.value == 3){
          lotValue = "Peti";
        }
      }

      return e.columnName == 'CheckBox'
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Checkbox(
                value: e.value,
                onChanged: (value) {
                  int index = rows.indexOf(row);

                  saleData[index].getCells()[0] =
                      DataGridCell<bool>(columnName: 'CheckBox', value: value);
                  if (value == true) {
                    dataGridController.selectedRow = row;
                  } else if (value == false) {
                    List<DataGridRow> newSelectedRows =
                        dataGridController.selectedRows.toList();
                    // To remove the corresponding row from the selectedRows list.
                    newSelectedRows.remove(row);
                    // To update the selectedRows list.
                    dataGridController.selectedRows = newSelectedRows;
                  }
                  if (dataGridController.selectedRows.isEmpty) {
                    isHeaderCheckboxState = false;
                  } else if (rows.length !=
                      dataGridController.selectedRows.length) {
                    isHeaderCheckboxState = null;
                  } else if (rows.length ==
                      dataGridController.selectedRows.length) {
                    isHeaderCheckboxState = true;
                  }
                  // To update the datagrid rows.
                  notifyListeners();
                  // To update the datagrid view.
                  _setState(() {});
                },
              ),
            )
          : e.columnName == 'lot'
              ? Container(
                  color: color,
                  alignment: Alignment.center,
                  child: Text(lotValue.toString()),
                )
              : Container(
                  color: color,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.value.toString()),
                );
    }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    // Call When user submit edited value
    // TODO: implement onCellSubmit
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            .value ?? '';

    final int dataRowIndex = saleData.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return Future<void>.value(null);
    }

    if (column.columnName == 'srNo') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'srNo', value: newCellValue);
      updatedData[dataRowIndex].srNo = newCellValue as int;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'itemName') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'itemName', value: newCellValue);
      updatedData[dataRowIndex].itemName = newCellValue.toString();
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'supplierName') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'supplierName', value: newCellValue);
      updatedData[dataRowIndex].supplierName = newCellValue.toString();
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'farmerName') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'farmerName', value: newCellValue);
      updatedData[dataRowIndex].farmerName = newCellValue.toString();
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'vclNo') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'vclNo', value: newCellValue);
      updatedData[dataRowIndex].vclNo = newCellValue.toString();
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'frightRate') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'frightRate', value: newCellValue);
      updatedData[dataRowIndex].frightRate = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'otherCharges') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'otherCharges', value: newCellValue);
      updatedData[dataRowIndex].otherCharges = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'labourRate') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'labourRate', value: newCellValue);
      updatedData[dataRowIndex].labourRate = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'sellerRate') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'sellerRate', value: newCellValue);
      updatedData[dataRowIndex].sellerRate = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'customerRate') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'customerRate', value: newCellValue);
      updatedData[dataRowIndex].customerRate = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'customerName') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'customerName', value: newCellValue);
      updatedData[dataRowIndex].customerName = newCellValue.toString();
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'customerNug') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'customerNug', value: newCellValue);
      updatedData[dataRowIndex].customerNug = newCellValue as int;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'sellerNug') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'sellerNug', value: newCellValue);
      updatedData[dataRowIndex].sellerNug = newCellValue as int;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'lot') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'lot', value: newCellValue);
      updatedData[dataRowIndex].lot = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'netWeight') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'netWeight', value: newCellValue);
      updatedData[dataRowIndex].netWeight = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'avgWeight') {
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'avgWeight', value: newCellValue);
      updatedData[dataRowIndex].avgWeight = newCellValue as double;
      updateDatabase(updatedData[dataRowIndex]);
    } else if (column.columnName == 'weight') {
      String w = newCellValue;

      List<int> numbers =
          w.split('+').map((String numString) => int.parse(numString)).toList();
      saleData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'weight', value: newCellValue.toString());
      updatedData[dataRowIndex].w = numbers;
      updateDatabase(updatedData[dataRowIndex]);
    }

    return super.onCellSubmit(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;
    var lotValue;
    List<String> listItem = [];

    final bool isNumericType = column.columnName == 'id' ||
        column.columnName == 'srNo' ||
        column.columnName == 'customerNug' ||
        column.columnName == 'sellerNug';

    final bool isDoubleType = column.columnName == 'grossWeight' ||
        column.columnName == 'netWeight' ||
        column.columnName == 'avgWeight' ||
        column.columnName == 'frightRate' ||
        column.columnName == 'otherCharges' ||
        column.columnName == 'labourRate' ||
        column.columnName == 'sellerRate' ||
        column.columnName == 'customerRate' ||
        column.columnName == 'lot';

    listItem.clear();

    Map<String, List<SaleModel>> listMap = {};

    if (updatedData.isNotEmpty) {
      updatedData.forEach((task) {
        if (column.columnName == 'supplierName') {
          if (!listMap.containsKey(task.supplierName)) {
            listMap[task.supplierName] = [];
          }
          listMap[task.supplierName]!.add(task);
        } else if (column.columnName == 'farmerName') {
          if (!listMap.containsKey(task.farmerName)) {
            listMap[task.farmerName] = [];
          }
          listMap[task.farmerName]!.add(task);
        } else if (column.columnName == 'customerName') {
          if (!listMap.containsKey(task.customerName)) {
            listMap[task.customerName] = [];
          }
          listMap[task.customerName]!.add(task);
        } else if (column.columnName == 'itemName') {
          if (!listMap.containsKey(task.itemName)) {
            listMap[task.itemName] = [];
          }
          listMap[task.itemName]!.add(task);
        }else if (column.columnName == 'lot') {
         listItem = ["Peti","Daba","Box","Plate"];

         if(displayText == "0.25"){
           lotValue = "Plate";
         }else if(displayText == "1.25"){
           lotValue = "Box";
         }else if(displayText == "0.5"){
           lotValue = "Daba";
         }else if(displayText == "3"){
           lotValue = "Peti";
         }
        }
      });

      listMap.forEach((key, value) {
        if (key != "") listItem.add('$key');
      });
    }
    if (editingController.text.isNotEmpty) {
      editingController.selection = TextSelection(
          baseOffset: 0, extentOffset: editingController.text.length);
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: column.columnName == 'lot'? RawAutocomplete<String>(
        textEditingController: editingController..text = lotValue,
        focusNode: FocusNode(),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return listItem;
          } else {
            List<String> matches = <String>[];
            matches.addAll(listItem);
            matches.retainWhere((s) {
              return s
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
            return matches;
          }
        },
        onSelected: (String selection) {
          if(selection == "Plate"){
            newCellValue = 0.25;
          }else if(selection == "Box"){
            newCellValue = 1.25;
          }else if(selection == "Daba"){
            newCellValue = 0.5;
          }else if(selection == "Peti"){
            newCellValue = 3;
          }
          _setState(() {});
          submitCell();
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
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            onChanged: (selection) {
              if(selection == "Plate"){
                newCellValue = 0.25;
              }else if(selection == "Box"){
                newCellValue = 1.25;
              }else if(selection == "Daba"){
                newCellValue = 0.5;
              }else if(selection == "Peti"){
                newCellValue = 3;
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
                        _setState(() {});
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
      ): column.columnName != 'supplierName' &&
              column.columnName != 'farmerName' &&
              column.columnName != 'itemName' &&
              column.columnName != 'customerName'
          ? TextFormField(
              enableSuggestions: true,
              autofocus: true,
              controller: editingController..text = displayText,
              textAlign: isNumericType ? TextAlign.right : TextAlign.left,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
              ),
              keyboardType:
                  isNumericType ? TextInputType.number : TextInputType.text,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  if (isNumericType) {
                    newCellValue = int.parse(value);
                  } else if (isDoubleType) {
                    newCellValue = double.parse(value);
                  } else {
                    newCellValue = value;
                  }
                } else {
                  newCellValue = null;
                }
              },
              onSaved: (String? value) {
                // Calls when cell Submitted
                submitCell();
              },
            ) :
          RawAutocomplete<String>(
              textEditingController: editingController..text = displayText,
              focusNode: FocusNode(),
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return listItem;
                } else {
                  List<String> matches = <String>[];
                  matches.addAll(listItem);
                  matches.retainWhere((s) {
                    return s
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (String selection) {
                _setState(() {});
                newCellValue = selection;
                submitCell();
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
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  onChanged: (newValue) {
                    newCellValue = newValue;
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
                              _setState(() {});
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
    );
  }

  void updateDatabase(SaleModel saleModel) {
    bool isCal = false;
    double grossWeight = 0; // GrossWeight = w1+w2+w3.....+wN
    double cut = 0;
    saleModel.w.forEach((element) {
      if (element != 0) {
        isCal = true;
      }
    });

    if (isCal) {
      //GrossWeight Calculation
      for (int i = 0; i < saleModel.w.length; i++) {
        grossWeight = grossWeight + saleModel.w[i];
      }
      cut = saleModel.lot;
      saleModel.grossWeight = grossWeight;
      //Net Weight Calculation
      saleModel.netWeight = grossWeight -
          (saleModel.customerNug *
              cut); // NetWeight = GrossWeight - (C.Nug * Cut)
      //Average Weight
      saleModel.avgWeight =
          (saleModel.netWeight / saleModel.customerNug) * saleModel.sellerNug;
    }

    //Basic and bikri Amount Claculation
    if (grossWeight == 0) {
      saleModel.basicAmt = saleModel.customerNug * saleModel.customerRate;
      saleModel.bikriAmt = saleModel.sellerNug * saleModel.sellerRate;
    } else {
      saleModel.basicAmt = saleModel.netWeight * saleModel.customerRate;
      saleModel.bikriAmt = saleModel.avgWeight * saleModel.sellerRate;
    }

    final isar = IsarProvider.isar;
    isar.writeTxn(() async => isar.saleModels.put(saleModel));
    // To update the datagrid rows.
    notifyListeners();
    // To update the datagrid view.
    _setState(() {});
  }
}

class DataRepository {
  Future<List<SaleModel>> getSale() async {
    final isar = Isar.getInstance();
    return isar!.writeTxn(() {
      return isar.saleModels.where().findAll();
      //return isar.saleModels.where().sortBySupplierNameDesc().findAll();
    });
  }
}
