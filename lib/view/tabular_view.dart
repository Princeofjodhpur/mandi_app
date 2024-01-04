import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/utils/isar_provider.dart';
import 'package:mandi_app/utils/table_view_columns.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TabularView extends StatefulWidget {
  const TabularView({Key? key}) : super(key: key);
  @override
  State<TabularView> createState() => _TabularViewState();
}

class _TabularViewState extends State<TabularView> {
  late final PlutoGridStateManager stateManager;
  final isar = IsarProvider.isar;

  void updateDatabase(PlutoGridOnChangedEvent plutoGridOnChangedEvent) {
    // update the isar database when a cell is edited
    var row = stateManager.getRowByIdx(plutoGridOnChangedEvent.rowIdx);
    var object = SaleModel()..fromPlutoRow(row!);
    isar.saleModels.put(object);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SaleModel>>(
      // First, load the data from the database
      future: isar.saleModels.where().findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Once the data is loaded, start listening for updates
          return StreamBuilder<List<SaleModel>>(
            stream: isar.saleModels.where().watch(),
            initialData: snapshot.data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var rows = snapshot.data!.map((e) => e.toPlutoRow()).toList();
                return PlutoGrid(
                    key: ValueKey(DateTime.now()),
                    columns: tableViewColumns,
                    rows: rows,
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      stateManager = event.stateManager;
                    },
                    onChanged: updateDatabase);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }
      },
    );
  }
}
