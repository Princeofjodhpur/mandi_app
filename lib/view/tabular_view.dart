import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TabularView extends StatefulWidget {
  const TabularView({Key? key}) : super(key: key);
  @override
  State<TabularView> createState() => _TabularViewState();
}

class _TabularViewState extends State<TabularView> {
  late final PlutoGridStateManager stateManager;

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Sr. No.',
      field: 'srNo',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'VCL No.',
      field: 'vclNo',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Creation Date',
      field: 'creationDate',
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Farmer Name',
      field: 'farmerName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Supplier Name',
      field: 'supplierName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Item Name',
      field: 'itemName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Gross Weight',
      field: 'grossWeight',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Net Weight',
      field: 'netWeight',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Avg. Weight',
      field: 'avgWeight',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W1',
      field: 'w1',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W2',
      field: 'w2',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W3',
      field: 'w3',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W4',
      field: 'w4',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W5',
      field: 'w5',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W6',
      field: 'w6',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W7',
      field: 'w7',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W8',
      field: 'w8',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W9',
      field: 'w9',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'W10',
      field: 'w10',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Fright Rate',
      field: 'frightRate',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Other Charges',
      field: 'otherCharges',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Labour Rate',
      field: 'labourRate',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Seller Rate',
      field: 'sellerRate',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Customer Rate',
      field: 'customerRate',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Customer Name',
      field: 'customerName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Customer Nug',
      field: 'customerNug',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Lot',
      field: 'lot',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Seller Nug',
      field: 'sellerNug',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Cut',
      field: 'cut',
      type: PlutoColumnType.text(),
    ),
  ];

  final List<PlutoRow> rows = List<PlutoRow>.generate(
      30,
      (index) => PlutoRow(
            cells: {
              'srNo': PlutoCell(value: 1),
              'vclNo': PlutoCell(value: 'vclNo'),
              'creationDate': PlutoCell(value: DateTime.now()),
              'farmerName': PlutoCell(value: 'farmerName'),
              'supplierName': PlutoCell(value: 'supplierName'),
              'itemName': PlutoCell(value: 'itemName'),
              'grossWeight': PlutoCell(value: 1),
              'netWeight': PlutoCell(value: 1),
              'avgWeight': PlutoCell(value: 1),
              'w1': PlutoCell(value: 1),
              'w2': PlutoCell(value: 1),
              'w3': PlutoCell(value: 1),
              'w4': PlutoCell(value: 1),
              'w5': PlutoCell(value: 1),
              'w6': PlutoCell(value: 1),
              'w7': PlutoCell(value: 1),
              'w8': PlutoCell(value: 1),
              'w9': PlutoCell(value: 1),
              'w10': PlutoCell(value: 1),
              'frightRate': PlutoCell(value: 1),
              'otherCharges': PlutoCell(value: 1),
              'labourRate': PlutoCell(value: 1),
              'sellerRate': PlutoCell(value: 1),
              'customerRate': PlutoCell(value: 1),
              'customerName': PlutoCell(value: 'customerName'),
              'customerNug': PlutoCell(value: 1),
              'lot': PlutoCell(value: 1),
              'sellerNug': PlutoCell(value: 1),
              'cut': PlutoCell(value: 'cut'),
            },
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          // columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            // print(event);
          },
          configuration: const PlutoGridConfiguration(),
        ),
      ),
    );
  }
}
