import 'package:mandi_app/controller/data_controller.dart';
import 'package:mandi_app/model/sale_model.dart';

class MainController {
  final DataController dataController = DataController();

  List<SaleModel> fetchData() {
    // Implement logic to fetch data from the database
    return dataController.fetchData();
  }

  void printData(SaleModel data) {
    // Implement logic to print data
    print('Printing data: ${data.field1}, ${data.field2}');

    var data = SaleModel(
      avgWeight: 0,
    );
  }
}
