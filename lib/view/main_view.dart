import 'package:flutter/material.dart';
import 'package:mandi_app/view/tabular_view.dart';
import 'package:mandi_app/view/form_view.dart';
import 'package:mandi_app/view/print_view.dart';
import 'package:mandi_app/controller/main_controller.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainController mainController = MainController();
  bool _isExtended = false; // Default extended state (collapsed)
  int _selectedIndex = 2; // Default selected index (Dashboard)
  late Widget _currentView;

  @override
  void initState() {
    super.initState();
    _currentView = const TabularView(); // Default view is TabularView
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandi Management App'),
      ),
      body: Row(
        children: [
          // Left pane - Navigation Rail
          NavigationRail(
            extended: _isExtended,
            groupAlignment: -1.0, //Algihns the items to the top
            destinations: [
              NavigationRailDestination(
                icon: IconButton(
                  icon: Icon(_isExtended ? Icons.arrow_back_ios : Icons.menu),
                  onPressed: () {
                    setState(() {
                      _isExtended = !_isExtended;
                    });
                  },
                ),
                label: const Text('Expand/Collapse'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.add), // "Create New Entry" icon
                label: Text('Create Entry'),
              ),
              const NavigationRailDestination(
                // Tabular view
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              const NavigationRailDestination(
                // Print view
                icon: Icon(Icons.print),
                label: Text('Prints'),
              ),
            ],
            selectedIndex: _selectedIndex, // Default selected index (Dashboard)
            onDestinationSelected: (int index) {
              setState(() {
                switch (index) {
                  case 1:
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const FormView()),
                    // );
                    _selectedIndex = index;
                    _currentView = const SaleFormView();
                    break;
                  case 2:
                    _selectedIndex = index;
                    _currentView = const TabularView();
                    break;
                  case 3:
                    _selectedIndex = index;
                    _currentView =
                        const PrintView(); // Assume you have a PrintView widget
                    break;
                }
              });
            },
          ),
          // Right pane - Content
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.grey),
                  right: BorderSide(width: 1.0, color: Colors.grey),
                  top: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              // width: 1300.00,
              // height: 500.00,
              child: _currentView, // Content view based on navigation
            ),
          ),
        ],
      ),
    );
  }
}
