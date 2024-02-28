import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/utils/isar_provider.dart';

import '../model/sale_model.dart';
import '../view/pdfView.dart';


class PrintFormatOne extends StatefulWidget {
  const PrintFormatOne({super.key});

  @override
  State<PrintFormatOne> createState() => _PrintFormatOneState();
}

class _PrintFormatOneState extends State<PrintFormatOne> {
  var printData;
  final isar = IsarProvider.isar;
  List<String> vclArray = [];
  String selected_vcl_no = "";
  String selectedDate = "";

  Future<Map<String, List<SaleModel>>> groupTasksByVehicle() async {
    var record = await isar.saleModels.where().findAll();
    Map<String, List<SaleModel>> groupedTasks = {};

    record.forEach((task) {

      if (!groupedTasks.containsKey(task.vclNo)) {
        groupedTasks[task.vclNo] = [];
      }
      groupedTasks[task.vclNo]!.add(task);
    });

    return groupedTasks;
  }
  List<SaleModel>? saleModel;
  Map<String, String> lotList = {
    "3" : "Peti",
    "0.5" : "Daba",
    "1.25" : "Box",
    "0.25" : "Plate",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now().toString().substring(0,10);

    //getData();
  }

  Future<Map<String, List<SaleModel>>> groupTasksBySupplier() async {
    // Code For Grouping Same Supplier Name entries
    var record = await isar.saleModels.where().findAll();
    Map<String, List<SaleModel>> groupedTasks = {};

    record.forEach((task) {
      if (!groupedTasks.containsKey(task.supplierName)) {
        groupedTasks[task.supplierName] = [];
      }
      groupedTasks[task.supplierName]!.add(task);
    });

    return groupedTasks;
  }


  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) async {
        if ((event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
            event.isKeyPressed(LogicalKeyboardKey.controlRight)) &&
            event.isKeyPressed(LogicalKeyboardKey.keyP)) {
          final pdf = await generatePdfFromListView();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfViewer(pdfPath: pdf)));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('(श्री गणेशाय नमः)', style: TextStyle(color: Colors.white))),
            backgroundColor: Colors.blue, // Using blue color for the app bar
            elevation: 0, // No shadow for the app bar
            actions: [
              IconButton(
                onPressed: () async {
                  DateTime? tillDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 30),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.calendarOnly
                  );

                  if (tillDate != null) {
                    //startingDate.text = datePicked.toString();
                    selectedDate = DateFormat('yyyy-MM-dd').format(tillDate);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.calendar_month,color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  child: const Icon(Icons.emoji_transportation, color: Colors.white,),
                  onTap: () {
                    vclArray.clear();
                    vclArray.add("All");
                    Future<Map<String, List<SaleModel>>> data = groupTasksByVehicle();
                    data.then((result) {
                      // Iterate over the map and print each entry
                      result.forEach((vehicle, sales) {
                        vclArray.add(vehicle.toString());
                        setState(() {});
                      });

                      // dialog show after vehicle sorting
                      showDialog(
                        context: context, builder: (builder){
                        return SimpleDialog(
                          title: const Text("Select Vehicle"),
                          children: List.generate(vclArray.length, (index){
                            return SimpleDialogOption(
                              onPressed: (){
                                Navigator.pop(context);
                                selected_vcl_no = vclArray[index];
                                if(vclArray[index] == "All"){ selectedDate = ""; selected_vcl_no = "";};
                                vclArray.clear();
                                setState(() {});
                              },
                              child: Text(vclArray[index]),
                            );
                          }),
                        );
                      },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          body: FutureBuilder<Map<String, List<SaleModel>>>(
            future: groupTasksBySupplier(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final saleData = snapshot.data!;
                printData = saleData;
                return MasonryGridView.count(
                  crossAxisCount: 2,
                  itemBuilder: (context,index){
                    final supplier = saleData.keys.elementAt(index);
                    final sale = saleData[supplier]!;
                    Map<String, List<SaleModel>> data = {};
                    sale.forEach((element) {
                      if (selected_vcl_no != "" && selectedDate != "") { // Filter Condition for both VCL no and Date
                        if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                        }
                      }else if (selectedDate != "" || selected_vcl_no != "") { // If Only One is selected from VCL no and Date
                        if(element.creationDate.toString().substring(0,10) == selectedDate){
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                          // vcl_no = element.creationDate.toString().substring(0,10);
                        }else if (element.vclNo == selected_vcl_no) {
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                          //vcl_no = element.vclNo;
                        }
                      } else{
                        // If nothing is selected for All Vcl Condition
                        if (!data.containsKey(element.farmerName)) {
                          data[element.farmerName] = [];
                        }
                        data[element.farmerName]!.add(element);
                        //vcl_no = element.vclNo;
                      }
                    });
                    return data.isEmpty ? Container() : Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(supplier,style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final farmer = data.keys.elementAt(index);
                              final farmerData = saleData[supplier]!;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Text(farmer,style: const TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          decoration: const BoxDecoration(
                                              border: Border.symmetric(horizontal: BorderSide(color: Colors.black))
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(farmerData[index].srNo.toString(),style: const TextStyle(fontWeight: FontWeight.normal),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: farmerData.length,
                                    itemBuilder: (context, index) {
                                      final task = farmerData[index];
                                      List<int> filteredItems = task.w.where((item) => item != 0).toList();
                                      String weightString = filteredItems.join(', ');
                                      return task.farmerName == farmer ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey))
                                                  ),
                                                  child: Text(task.lot.toString(),style: const TextStyle(fontWeight: FontWeight.normal),),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(lotList.containsKey(task.lot.toString())? lotList[task.lot.toString()]!:"",style: const TextStyle(fontWeight: FontWeight.normal),),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey))
                                                  ),
                                                  child: Text(task.customerNug.toString(),style: const TextStyle(fontWeight: FontWeight.normal),),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey))
                                                  ),
                                                  child: Text(task.customerName.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(weightString,style: const TextStyle(fontWeight: FontWeight.normal),),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ) : Container();
                                    },
                                  ),
                                ],
                              );
                            },
                          ),

                        ],
                      ),
                    );
                  },
                  itemCount: saleData.length,
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            isExtended: true,
            onPressed: () async {
              final pdf = await generatePdfFromListView();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfViewer(pdfPath: pdf)));
            },
            child: const Icon(Icons.print),
          ),
        ),
      ),
    );
  }

  Future<String> generatePdfFromListView() async {
    final pdf = pw.Document();
    final  font = await rootBundle.load("assets/font/hindi.ttf");
    final  ttf = pw.Font.ttf(font);
    pdf.addPage(
        pw.MultiPage(
            margin: const pw.EdgeInsets.all(5),
            build: (pw.Context context) {
              return [
                pw.Container(
                    color: PdfColors.blue,
                    height: 50,
                    width: double.infinity,
                    alignment: pw.Alignment.center,
                    child: pw.Text("(श्री गणेशाय नमः)",style: pw.TextStyle(font: ttf,color: PdfColors.white))
                ),
                pw.ListView.builder(
                  itemBuilder: (context,index){
                    final supplier = printData.keys.elementAt(index);
                    final sale = printData[supplier]!;
                    Map<String, List<SaleModel>> data = {};
                    sale.forEach((element) {
                      if (selected_vcl_no != "" && selectedDate != "") {
                        if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                        }
                      }else if (selectedDate != "" || selected_vcl_no != "") {
                        if(element.creationDate.toString().substring(0,10) == selectedDate){
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                          // vcl_no = element.creationDate.toString().substring(0,10);
                        }else if (element.vclNo == selected_vcl_no) {
                          if (!data.containsKey(element.farmerName)) {
                            data[element.farmerName] = [];
                          }
                          data[element.farmerName]!.add(element);
                          //vcl_no = element.vclNo;
                        }
                      } else{
                        if (!data.containsKey(element.farmerName)) {
                          data[element.farmerName] = [];
                        }
                        data[element.farmerName]!.add(element);
                        //vcl_no = element.vclNo;
                      }
                    });
                    return data.isEmpty ? pw.Container() : pw.Container(
                      margin: const pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black)
                      ),
                      child: pw.Column(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(vertical: 8),
                            child: pw.Text(supplier,style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                          pw.ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final farmer = data.keys.elementAt(index);
                              final farmerData = printData[supplier]!;
                              return pw.Column(
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Container(
                                          padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(color: PdfColors.black)
                                          ),
                                          child: pw.Text(farmer,style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                        ),
                                      ),
                                      pw.Expanded(
                                        child: pw.Container(
                                          padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          decoration: const pw.BoxDecoration(
                                              border: pw.Border.symmetric(horizontal: pw.BorderSide(color: PdfColors.black))
                                          ),
                                          child: pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Text(farmerData[index].srNo.toString(),style: pw.TextStyle(fontWeight: pw.FontWeight.normal),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.ListView.builder(
                                    itemCount: farmerData.length,
                                    itemBuilder: (context, index) {
                                      final task = farmerData[index];
                                      List<int> filteredItems = task.w.where((item) => item != 0).toList();
                                      String weightString = filteredItems.join(', ');
                                      return task.farmerName == farmer ? pw.Column(
                                        children: [
                                          pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Container(
                                                  padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const pw.BoxDecoration(
                                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey),right: pw.BorderSide(color: PdfColors.grey))
                                                  ),
                                                  child: pw.Text(task.lot.toString(),style: pw.TextStyle(fontWeight: pw.FontWeight.normal),),
                                                ),
                                              ),
                                              pw.Expanded(
                                                child: pw.Container(
                                                  padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const pw.BoxDecoration(
                                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey))
                                                  ),
                                                  child: pw.Align(
                                                    alignment: pw.Alignment.centerRight,
                                                    child: pw.Text(lotList.containsKey(task.lot.toString())? lotList[task.lot.toString()]!:"",style: pw.TextStyle(fontWeight: pw.FontWeight.normal),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Container(
                                                  padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const pw.BoxDecoration(
                                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey),right: pw.BorderSide(color: PdfColors.grey))
                                                  ),
                                                  child: pw.Text(task.customerNug.toString(),style:  pw.TextStyle(fontWeight: pw.FontWeight.normal),),
                                                ),
                                              ),
                                              pw.Expanded(
                                                child: pw.Container(
                                                  padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const pw.BoxDecoration(
                                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey),right: pw.BorderSide(color: PdfColors.grey))
                                                  ),
                                                  child: task.customerName.toString() != "" ? pw.Text(task.customerName.toString(),style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),): pw.Container(height: 14),
                                                ),
                                              ),
                                              pw.Expanded(
                                                child: pw.Container(
                                                  padding: const pw.EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  decoration: const pw.BoxDecoration(
                                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey))
                                                  ),
                                                  child: pw.Align(
                                                    alignment: pw.Alignment.centerRight,
                                                    child: pw.Text(weightString,style:  pw.TextStyle(fontWeight: pw.FontWeight.normal),),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ) : pw.Container();
                                    },
                                  ),
                                ],
                              );
                            },
                          ),

                        ],
                      ),
                    );
                  },
                  itemCount: printData.length),
              ];
            }
        )
    );

    // Get the document directory using path_provider
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    // Generate a unique file name
    final String pdfPath = '${appDocDir.path}/example.pdf';

    // Write the PDF file
    final File pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfPath;
  }
}


