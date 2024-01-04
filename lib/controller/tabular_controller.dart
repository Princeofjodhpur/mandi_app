import 'package:isar/isar.dart';
import 'package:mandi_app/services/isar_provider.dart';

class TabularController {
  static Future<void> fetchData() {
    final isar = IsarProvider.isar;

    return Future(() => null);
    // await isar.txn(() async {
    //   await isar.saleModels;
    // });
  }
}
