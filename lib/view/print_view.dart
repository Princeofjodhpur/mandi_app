import 'package:flutter/material.dart';
import 'package:mandi_app/printing/format1.dart';

import '../printing/format2.dart';
import '../printing/format3.dart';

class PrintView extends StatelessWidget {
  const PrintView({super.key});



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Print View'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Format 1'),
              Tab(text: 'Format 2'),
              Tab(text: 'Format 3'),
              // Add more tabs for additional formats
            ],
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () async {

          },
          child: const Icon(Icons.print),
        ),*/
        body: TabBarView(
          children: [
            // Content for Format 1
            SizedBox(width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,child: const PrintFormatOne()),
            // Content for Format 2
            SizedBox(width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,child: const PrintFormatTwo()),
            SizedBox(width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,child: const PrintFormatThree()),
          ],
        ),
      ),
    );
  }


}
