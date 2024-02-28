import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mandi_app/model/sale_model.dart';

class IsarProvider {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [SaleModelSchema],
      directory: dir.path,
    );
    getIt.registerSingleton<Isar>(isar);
  }

  static Isar get isar => getIt<Isar>();
}
