import 'package:flutter/material.dart';
import 'package:mandi_app/utils/isar_provider.dart';
import 'package:mandi_app/view/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarProvider.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mandi Management App',
      home: MainView(),
    );
  }
}
