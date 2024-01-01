import 'package:flutter/material.dart';

class PrintView extends StatelessWidget {
  const PrintView({Key? key}) : super(key: key);

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
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            // Implement your logic for printing
          },
          child: const Icon(Icons.print),
        ),
        body: const TabBarView(
          children: [
            // Content for Format 1
            Center(child: Text('Format 1 Content')),
            // Content for Format 2
            Center(child: Text('Format 2 Content')),
            // Content for Format 3
            Center(child: Text('Format 3 Content')),
            // Add more content for additional formats
          ],
        ),
      ),
    );
  }
}
