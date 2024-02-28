import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:mandi_app/view/pdfView.dart';
import 'package:tuple/tuple.dart';

import '../utils/isar_provider.dart';


class PrintFormatTwo extends StatefulWidget {
  const PrintFormatTwo({super.key});

  @override
  State<PrintFormatTwo> createState() => _PrintFormatTwoState();
}

class _PrintFormatTwoState extends State<PrintFormatTwo> {
  var data;
  final isar = IsarProvider.isar;
  List<String> vclArray = [];
  String selected_vcl_no = "";
  String selectedDate = "";


  Future<Map<Tuple2<String, String>, List<SaleModel>>> groupTasksByitemName() async {
    // Code For Grouping Same itemName entries
    var record = await isar.saleModels.where().findAll();
    Map<Tuple2<String, String>, List<SaleModel>> groupedTasks = {};


    record.forEach((task) {
      var key = Tuple2(task.itemName, task.vclNo);
      if (!groupedTasks.containsKey(key)) {
        groupedTasks[key] = [];
      }

      groupedTasks[key]!.add(task);
    });

    return groupedTasks;
  }

  Future<Map<String, List<SaleModel>>> groupTasksByVehicle() async {
    // Code For Grouping Same VCL no entries
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now().toString().substring(0,10);
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
            IconButton(
              onPressed: () async {
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
                            setState(() {

                            });
                          },
                          child: Text(vclArray[index]),
                        );
                      }),
                    );
                  },
                  );
                });
                setState(() {});
              },
              icon: const Icon(Icons.emoji_transportation,color: Colors.white,),
            ),
          ],
        ),
        body: FutureBuilder<Map<Tuple2<String, String>, List<SaleModel>>>(
          future: groupTasksByitemName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final saleData = snapshot.data!;
              data = saleData;
              return MasonryGridView.count(
                  crossAxisCount: 2,
                itemCount: saleData.length,
                itemBuilder: (context, index) {
                  var supplier = saleData.keys.elementAt(index);
                  var vcl_no;

                  final sale = saleData[supplier]!;

                  int total_basicAmt = 0,total_c_nug = 0;
                  double total_net_weight =0;
                  List show_item = [];
                  for (var element in sale) {
                    if (selected_vcl_no != "" && selectedDate != "") { // Filter Condition for both VCL no and Date
                      if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                        show_item.add(element);
                        vcl_no = element.creationDate.toString().substring(0,10);

                        total_basicAmt = total_basicAmt + element.basicAmt.toInt(); // total basic Amount
                        total_c_nug = total_c_nug + element.customerNug.toInt();
                        total_net_weight = total_net_weight + element.netWeight;
                      }
                    }else if (selectedDate != "" || selected_vcl_no != "") { // If Only One is selected from VCL no and Date
                      if(element.creationDate.toString().substring(0,10) == selectedDate){
                        show_item.add(element);
                        vcl_no = element.creationDate.toString().substring(0,10);

                        total_basicAmt = total_basicAmt + element.basicAmt.toInt();
                        total_c_nug = total_c_nug + element.customerNug.toInt();
                        total_net_weight = total_net_weight + element.netWeight;
                      }else if (element.vclNo == selected_vcl_no) {
                        total_basicAmt = total_basicAmt + element.basicAmt
                            .toInt();
                        total_c_nug = total_c_nug + element.customerNug.toInt();
                        total_net_weight = total_net_weight + element.netWeight;

                        show_item.add(element);
                        if(vcl_no != element.vclNo || vcl_no == null){
                          vcl_no = element.vclNo;
                        }
                      }
                    } else{
                      // If nothing is selected for All Vcl Condition
                        total_basicAmt = total_basicAmt + element.basicAmt.toInt();
                        total_c_nug = total_c_nug + element.customerNug.toInt();
                        total_net_weight = total_net_weight + element.netWeight;

                        show_item.add(element);
                        if(vcl_no != element.vclNo || vcl_no == null){
                          vcl_no = element.vclNo;
                        }
                    }
                  }
                  return show_item.isEmpty ? Container() : Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black))
                                ),
                                child: Text(supplier.item1,
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black),)
                                ),
                                child: Text(supplier.item2,
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingContainer("BASIC AMT"),
                            headingContainer("CUSTOMER NAME"),
                            headingContainer("C. NUG"),
                            headingContainer("NET WEIGHT"),
                            headingContainer("C.R"),
                          ],
                        ),
                        ListView.builder(itemBuilder: (context, index) {
                          return Row(
                            children: [
                              listingContainer(show_item[index].basicAmt.toStringAsFixed(2)),
                              listingContainer(show_item[index].customerName),
                              listingContainer(show_item[index].customerNug.toString()),
                              listingContainer(show_item[index].netWeight.toStringAsFixed(2)),
                              listingContainer(show_item[index].customerRate.toStringAsFixed(2)),
                            ],
                          );
                        },
                          itemCount: show_item.length,
                          shrinkWrap: true,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey))
                                ),
                                child: Text(total_basicAmt.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey))
                                ),
                                child: const Text("(TOTAL)", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey))
                                ),
                                child: Text(total_c_nug.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey)),
                                ),
                                child: Text(total_net_weight.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
    );
  }

  Widget headingContainer(String heading) {
    // heading Items For Listing
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black))
        ),
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(heading, style: const TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
      ),
    );
  }

  pw.Widget headingContainerPdf(String heading) {
    // heading Items For PDF
    return pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.center,
        decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black),
                right: pw.BorderSide(color: PdfColors.black))
        ),
        padding: const pw.EdgeInsets.only(bottom: 5, top: 5),
        child: pw.Text(heading, style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
      ),
    );
  }

  Widget listingContainer(String item) {
    // Listing Items For Listing
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey))
        ),
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(item, style: const TextStyle(fontWeight: FontWeight.normal),),
      ),
    );
  }

  pw.Widget listingContainerPdf(String item) {
    // Listing Items For PDF
    return pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.center,
        decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey),
                right: pw.BorderSide(color: PdfColors.grey))
        ),
        padding: const pw.EdgeInsets.only(bottom: 5, top: 5),
        child: item !="" ? pw.Text(item, style: pw.TextStyle(fontWeight: pw.FontWeight.normal),) : pw.Container(height: 14),
      ),
    );
  }

  Future<String> generatePdfFromListView() async {
    // PDF Generation Code
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
                  itemBuilder: (context, index) {
                    var supplier = data.keys.elementAt(index);
                    var vcl_no;

                    final sale = data[supplier]!;

                    int total_basicAmt = 0,total_c_nug = 0;
                    double total_net_weight =0;
                    List show_item = [];
                    for (var element in sale) {
                      if (selected_vcl_no != "" && selectedDate != "") {
                        if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                          show_item.add(element);
                          vcl_no = element.creationDate.toString().substring(0,10);

                          total_basicAmt = total_basicAmt + element.basicAmt.toInt() as int;
                          total_c_nug = total_c_nug + element.customerNug.toInt() as int;
                          total_net_weight = total_net_weight + element.netWeight;
                        }
                      }else if (selectedDate != "" || selected_vcl_no != "") {
                        if(element.creationDate.toString().substring(0,10) == selectedDate){
                          show_item.add(element);
                          vcl_no = element.creationDate.toString().substring(0,10);

                          total_basicAmt = total_basicAmt + element.basicAmt.toInt() as int;
                          total_c_nug = total_c_nug + element.customerNug.toInt() as int;
                          total_net_weight = total_net_weight + element.netWeight;
                        }else if (element.vclNo == selected_vcl_no) {
                          total_basicAmt = total_basicAmt + element.basicAmt.toInt() as int;
                          total_c_nug = total_c_nug + element.customerNug.toInt() as int;
                          total_net_weight = total_net_weight + element.netWeight;

                          show_item.add(element);
                          if(vcl_no != element.vclNo || vcl_no == null){
                            vcl_no = element.vclNo;
                          }
                        }
                      } else{
                        total_basicAmt = total_basicAmt + element.basicAmt.toInt() as int;
                        total_c_nug = total_c_nug + element.customerNug.toInt() as int;
                        total_net_weight = total_net_weight + element.netWeight;

                        show_item.add(element);
                        if(vcl_no != element.vclNo || vcl_no == null){
                          vcl_no = element.vclNo;
                        }
                      }
                    }

                    return show_item.isEmpty ? pw.Container() : pw.Container(
                      margin: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black)
                      ),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  width: double.maxFinite,
                                  height: 40,
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(left: 10),
                                  decoration: const pw.BoxDecoration(
                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black),right: pw.BorderSide(color: PdfColors.black))
                                  ),
                                  child: pw.Text(supplier.item1,
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  width: double.maxFinite,
                                  height: 40,
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(left: 10),
                                  decoration: const pw.BoxDecoration(
                                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black),)
                                  ),
                                  child: pw.Text(supplier.item2,
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              headingContainerPdf("BASIC AMT"),
                              headingContainerPdf("CUSTOMER NAME"),
                              headingContainerPdf("C. NUG"),
                              headingContainerPdf("NET WEIGHT"),
                              headingContainerPdf("C.R"),
                            ],
                          ),
                          pw.ListView.builder(itemBuilder: (context, index) {
                            return pw.Row(
                              children: [
                                listingContainerPdf(show_item[index].basicAmt.toStringAsFixed(2)),
                                listingContainerPdf(show_item[index].customerName.toString()),
                                listingContainerPdf(show_item[index].customerNug.toString()),
                                listingContainerPdf(show_item[index].netWeight.toStringAsFixed(2)),
                                listingContainerPdf(show_item[index].customerRate.toStringAsFixed(2)),
                              ],
                            );
                          },
                            itemCount: show_item.length,
                          ),
                          pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 10),
                                  decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(color: PdfColors.grey),
                                          right: pw.BorderSide(color: PdfColors.grey))
                                  ),
                                  child: pw.Text(total_basicAmt.toString(),
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(bottom: 10, top: 10),
                                  decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(color: PdfColors.grey),
                                          right: pw.BorderSide(color: PdfColors.grey))
                                  ),
                                  child: pw.Text("(TOTAL)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(bottom: 10, top: 10),
                                  decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(color: PdfColors.grey),
                                          right: pw.BorderSide(color: PdfColors.grey))
                                  ),
                                  child: pw.Text(total_c_nug.toString(),
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.only(
                                      bottom: 10, top: 10, left: 10),
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(color: PdfColors.grey),
                                        right: pw.BorderSide(color: PdfColors.grey)),
                                  ),
                                  child: pw.Text(total_net_weight.toString(),
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                ),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: data.length),
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
