import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/services/isar_provider.dart';

class SaleFormController {
  // logic to save data to isar database
  static Future<void> saveSaleModel(SaleModel saleModel) async {
    final isar = IsarProvider.isar;

    await isar.writeTxn(() async {
      await isar.saleModels.put(saleModel);
    });
  }
}
