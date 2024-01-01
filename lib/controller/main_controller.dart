import 'package:mandi_app/controller/data_controller.dart';
import 'package:mandi_app/model/data_model.dart';

class MainController {
  final DataController dataController = DataController();

  List<DataModel> fetchData() {
    // Implement logic to fetch data from the database
    return dataController.fetchData();
  }

  void printData(DataModel data) {
    // Implement logic to print data
    print('Printing data: ${data.field1}, ${data.field2}');
  }
}
