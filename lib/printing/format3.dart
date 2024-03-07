import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mandi_app/model/sale_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/isar_provider.dart';
import '../view/pdfView.dart';

class PrintFormatThree extends StatefulWidget {
  const PrintFormatThree({super.key});

  @override
  State<PrintFormatThree> createState() => _PrintFormatThreeState();
}

class _PrintFormatThreeState extends State<PrintFormatThree> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  var data;
  final isar = IsarProvider.isar;
  List<String> dateArray = [];
  List<String> vclArray = [];
  String selectedDate = "",selected_vcl_no = "";

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
        print("kfdcjskd");
        if ((event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
            event.isKeyPressed(LogicalKeyboardKey.controlRight)) &&
            event.isKeyPressed(LogicalKeyboardKey.keyP)) {
          final pdf = await generatePdfFromListView();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfViewer(pdfPath: pdf)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('SALE PROCEED', style: TextStyle(color: Colors.white))),
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
              data = saleData;
              return ListView.builder(itemBuilder: (context, index) {
                final supplier = saleData.keys.elementAt(index) ;

                final sale = saleData[supplier]!;
                var vcl_no,sr_no,date;
                List show_item = [];

                int totalNug = 0,total_avg_weigth = 0,total_bikri_amt = 0,total_other_charges = 0,total_freight_charges = 0,total_labour = 0 , total_amt = 0;

                sale.forEach((element) {
                  totalNug = totalNug + element.sellerNug as int;
                  total_avg_weigth = total_avg_weigth + element.avgWeight.toInt() as int;
                  total_bikri_amt = total_bikri_amt + element.bikriAmt.toInt() as int;
                  total_other_charges = total_other_charges + ((element.basicAmt.toInt()*element.otherCharges.toInt())/100).toInt() as int;
                  if(element.lot.toString() == "0.25" || element.lot.toString() == "0.5"){
                    total_freight_charges = total_freight_charges + ((element.frightRate.toInt() * element.sellerNug)/2).toInt() as int;
                    total_labour = total_labour + ((element.labourRate.toInt() * element.sellerNug)/2).toInt() as int;
                  }else{
                    print(total_freight_charges.toString());
                    total_freight_charges = total_freight_charges + (element.frightRate.toInt() * element.sellerNug) as int;
                    total_labour = total_labour + (element.labourRate.toInt() * element.sellerNug) as int;
                  }

                  if (selected_vcl_no != "" && selectedDate != "") { // Filter Condition for both VCL no and Date
                    if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                      show_item.add(element);
                      vcl_no = element.vclNo;
                      sr_no = element.srNo;
                      date = element.creationDate.toString().substring(0,10);
                    }
                  }else if (selectedDate != "" || selected_vcl_no != "") { // If Only One is selected from VCL no and Date
                    if(element.creationDate.toString().substring(0,10) == selectedDate){
                      show_item.add(element);
                      vcl_no = element.vclNo;
                      sr_no = element.srNo;
                      date = element.creationDate.toString().substring(0,10);
                    }if( element.vclNo == selected_vcl_no){
                      show_item.add(element);
                      vcl_no = element.vclNo;
                      sr_no = element.srNo;
                      date = element.creationDate.toString().substring(0,10);
                    }
                  } else{
                    // If nothing is selected for All Vcl Condition
                    show_item.add(element);
                    vcl_no = element.vclNo;
                    sr_no = element.srNo;
                    date = element.creationDate.toString().substring(0,10);
                  }
                });

                int total_charges = total_labour+total_freight_charges+total_other_charges;

                total_amt = total_bikri_amt-total_charges;
                DateTime tempDate = new DateFormat("yyyy-MM-dd").parse( selectedDate != "" ? selectedDate: date);
                String showDate = tempDate.day.toString()+"/"+tempDate.month.toString()+"/"+tempDate.year.toString();

                return show_item.isEmpty ? Container() : Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(supplier,
                                    style: const TextStyle(fontWeight: FontWeight.bold),),
                                  DottedLine(lineLength: double.infinity,),
                                  Text("",
                                    style: const TextStyle(fontWeight: FontWeight.bold),),
                                  DottedLine(lineLength: double.infinity,)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black))
                              ),
                              padding: const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("$vcl_no", style: const TextStyle(
                                      fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("$showDate", style: const TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text("                  $sr_no", style: const TextStyle(
                                          fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        *//*decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))
                        ),*//*
                        child: const Text("DESCRIPTION OF GOODS",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingContainer("ITEM"),
                          headingContainer("FARMER"),
                          headingContainer("LOT"),
                          headingContainer("NUG"),
                          headingContainer("Weight"),
                          headingContainer("RATE"),
                          headingContainer("RATE P N"),
                          headingContainer("BIKRI AMT"),
                        ],
                      ),
                      ListView.builder(itemBuilder: (context, index) {
                        double rate_p_n = show_item[index].bikriAmt/show_item[index].sellerNug;
                        return Row(
                          children: [
                            listingContainer(show_item[index].itemName),
                            listingContainer(show_item[index].farmerName),
                            listingContainer(show_item[index].lot.toString()),
                            listingContainer(show_item[index].sellerNug.toString()),
                            listingContainer(show_item[index].avgWeight.toStringAsFixed(2)),
                            listingContainer(show_item[index].sellerRate.toStringAsFixed(2)),
                            listingContainer(rate_p_n.toStringAsFixed(2).toString()),
                            listingContainer(show_item[index].bikriAmt.toStringAsFixed(2)),
                          ],
                        );
                      },
                        itemCount: show_item.length,
                        shrinkWrap: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                        child: DottedLine(),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 2, top: 2, left: 10),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("Payment Mode",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 2, top: 2),
                             /* decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(totalNug.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 2, top: 2),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(total_avg_weigth.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 2, top: 2, left: 10),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("BASIC AMT",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 2, top: 2),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(total_bikri_amt.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("OTHER CHARGES",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(total_other_charges.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 2, top: 2, left: 10),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("TOTAL CHARGES",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 2, top: 2),
                             /* decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text("("+total_charges.toString()+")",
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("FREIGHT",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(total_freight_charges.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only( left: 10),
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("TOTAL AMT",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,

                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: Column(
                                children: [
                                  Divider(height: 5,color: Colors.black,),
                                  Text(total_amt.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Divider(height: 5,color: Colors.black,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey))
                              ),*/
                              child: const Text("LABOUR",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              /*decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey))
                              ),*/
                              child: Text(total_labour.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }, itemCount: saleData.length, key: _printKey,);
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

  Future<Map<String, List<SaleModel>>> groupTasksBySupplier() async {
    // Code For Grouping Same Supplier Name entries

    var record = await isar.saleModels.where().findAll();
    Map<String, List<SaleModel>> groupedTasks = {};

    record.forEach((task) {
      if (!groupedTasks.containsKey(task.supplierName)) {
        groupedTasks[task.supplierName] = [];
      }
      if(selectedDate == ""){
        groupedTasks[task.supplierName]!.add(task);
      }else{
        if(task.creationDate.toString().substring(0,10) == selectedDate){
          groupedTasks[task.supplierName]!.add(task);
        }
      }
    });


    return groupedTasks;
  }

  Future<Map<DateTime, List<SaleModel>>> groupTasksByDate() async {
    // Code For Grouping Same Date entries

    var record = await isar.saleModels.where().findAll();
    Map<DateTime, List<SaleModel>> groupedTasks = {};

    record.forEach((task) {

      if (!groupedTasks.containsKey(task.creationDate)) {
        groupedTasks[task.creationDate] = [];
      }
      groupedTasks[task.creationDate]!.add(task);
    });

    return groupedTasks;
  }

  Future<Map<String, List<SaleModel>>> groupTasksByVehicle() async {
    // Code For Grouping Same Vcl No. entries

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


  Widget headingContainer(String heading) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        /*decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black))
        ),*/
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(heading, style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
  pw.Widget headingContainerPDF(String heading) {
    return pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.center,
       /* decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black),
                right: pw.BorderSide(color: PdfColors.black))
        ),*/
        padding:  pw.EdgeInsets.only(bottom: 5, top: 5),
        child: pw.Text(heading, style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
      ),
    );
  }

  Widget listingContainer(String item) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        /*decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey))
        ),*/
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Text(item, style: const TextStyle(fontWeight: FontWeight.normal),),
      ),
    );
  }

  pw.Widget listingContainerPDF(String item) {
    return pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.center,/*
        decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey),
                right: pw.BorderSide(color: PdfColors.grey))
        ),*/
        padding: const pw.EdgeInsets.only(bottom: 5, top: 5),
        child: pw.Text(item, style: pw.TextStyle(fontWeight: pw.FontWeight.normal),),
      ),
    );
  }

  Future<String> generatePdfFromListView() async {
    final pdf = pw.Document();
    final  font = await rootBundle.load("assets/font/hindi.ttf");
    final  ttf = pw.Font.ttf(font);
      pdf.addPage(
          pw.MultiPage(
            margin: pw.EdgeInsets.all(5),
          build: (pw.Context context) {
            return [
              pw.Container(
                  color: PdfColors.blue,
                  height: 50,
                  width: double.infinity,
                  alignment: pw.Alignment.center,
                  child: pw.Text("(श्री गणेशाय नमः)",style: pw.TextStyle(font: ttf,color: PdfColors.white))
              ),
              pw.ListView.builder(itemBuilder: (context, index) {
              final supplier = data.keys.elementAt(index);
              final sale = data[supplier]!;
              var vcl_no,sr_no,date;
              List show_item = [];
              int totalNug = 0,total_avg_weigth = 0,total_bikri_amt = 0,total_other_charges = 0,total_freight_charges = 0,total_labour = 0 , total_amt = 0;
              sale.forEach((element) {
                totalNug = totalNug + element.sellerNug as int;
                total_avg_weigth = total_avg_weigth + element.avgWeight.toInt() as int;
                total_bikri_amt = total_bikri_amt + element.bikriAmt.toInt() as int;
                total_other_charges = total_other_charges + ((element.basicAmt.toInt()*element.otherCharges.toInt())/100).toInt() as int;
                if(element.lot.toString() == "0.25" || element.lot.toString() == "0.5"){
                  total_freight_charges = total_freight_charges + ((element.frightRate.toInt() * element.sellerNug)/2).toInt() as int;
                  total_labour = total_labour + ((element.labourRate.toInt() * element.sellerNug)/2).toInt() as int;
                }else{
                  print(total_freight_charges.toString());
                  total_freight_charges = total_freight_charges + (element.frightRate.toInt() * element.sellerNug) as int;
                  total_labour = total_labour + (element.labourRate.toInt() * element.sellerNug) as int;
                }

                if (selected_vcl_no != "" && selectedDate != "") {
                  if (element.vclNo.toString() == selected_vcl_no && element.creationDate.toString().substring(0, 10) == selectedDate) {
                    show_item.add(element);
                    vcl_no = element.vclNo;
                    sr_no = element.srNo;
                    date = element.creationDate.toString().substring(0,10);
                  }
                }else if (selectedDate != "" || selected_vcl_no != "") {
                  if(element.creationDate.toString().substring(0,10) == selectedDate){
                    show_item.add(element);
                    vcl_no = element.vclNo;
                    sr_no = element.srNo;
                    date = element.creationDate.toString().substring(0,10);
                  }if( element.vclNo == selected_vcl_no){
                    show_item.add(element);
                    vcl_no = element.vclNo;
                    sr_no = element.srNo;
                    date = element.creationDate.toString().substring(0,10);
                  }
                } else{
                  show_item.add(element);
                  vcl_no = element.vclNo;
                  sr_no = element.srNo;
                  date = element.creationDate.toString().substring(0,10);
                }
              });

              int total_charges = total_labour+total_freight_charges+total_other_charges;

              total_amt = total_bikri_amt-total_charges;
              DateTime tempDate = new DateFormat("yyyy-MM-dd").parse( selectedDate != "" ? selectedDate: date);
              String showDate = tempDate.day.toString()+"/"+tempDate.month.toString()+"/"+tempDate.year.toString();
              return show_item.isEmpty ? pw.Container() : pw.Container(
                margin: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black)
                ),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            height: 60,
                            padding: const pw.EdgeInsets.only(left: 10, top: 5),
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.black),
                                    right: pw.BorderSide(color: PdfColors.black))
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(supplier,
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                pw.Flex(
                                    children: List.generate(44, (_) {
                                      return pw.Container(
                                        margin: pw.EdgeInsets.symmetric(horizontal: 2),
                                        width: 2,
                                        height: 1,
                                        child: pw.DecoratedBox(
                                          decoration: pw.BoxDecoration(color: PdfColors.black),
                                        ),
                                      );
                                    }), direction: pw.Axis.horizontal),
                                pw.SizedBox(height: 15,),
                                pw.Flex(
                                    children: List.generate(44, (_) {
                                      return pw.Container(
                                        margin: pw.EdgeInsets.symmetric(horizontal: 2),
                                        width: 2,
                                        height: 1,
                                        child: pw.DecoratedBox(
                                          decoration: pw.BoxDecoration(color: PdfColors.black),
                                        ),
                                      );
                                    }), direction: pw.Axis.horizontal),
                              ]
                            )
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            height: 60,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.black))
                            ),
                            padding: const pw.EdgeInsets.only(
                                right: 10, top: 10, bottom: 5),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(vcl_no, style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),),
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Text("$showDate", style:  pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold),),
                                    pw.Text("                  $sr_no", style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        headingContainerPDF("ITEM"),
                        headingContainerPDF("FARMER"),
                        headingContainerPDF("LOT"),
                        headingContainerPDF("NUG"),
                        headingContainerPDF("Weight"),
                        headingContainerPDF("RATE"),
                        headingContainerPDF("RATE P N"),
                        headingContainerPDF("BIKRI AMT"),
                      ],
                    ),
                    pw.ListView.builder(itemBuilder: (context, index) {
                      double rate_p_n = show_item[index].bikriAmt/show_item[index].sellerNug;
                      return pw.Row(
                        children: [
                          listingContainerPDF(show_item[index].itemName),
                          listingContainerPDF(show_item[index].farmerName),
                          listingContainerPDF(show_item[index].lot.toString()),
                          listingContainerPDF(show_item[index].sellerNug.toString()),
                          listingContainerPDF(show_item[index].avgWeight.toStringAsFixed(2)),
                          listingContainerPDF(show_item[index].sellerRate.toStringAsFixed(2)),
                          listingContainerPDF(rate_p_n.toStringAsFixed(2).toString()),
                          listingContainerPDF(show_item[index].bikriAmt.toStringAsFixed(2)),
                        ],
                      );
                    },
                      itemCount: show_item.length,
                    ),
                    pw.Flex(
                        children: List.generate(91, (_) {
                          return pw.Container(
                            margin: pw.EdgeInsets.symmetric(horizontal: 2),
                            width: 2,
                            height: 1,
                            child: pw.DecoratedBox(
                              decoration: pw.BoxDecoration(color: PdfColors.black),
                            ),
                          );
                        }), direction: pw.Axis.horizontal),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(
                                bottom: 2, top: 2, left: 10),
                            /*decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child:  pw.Text("Payment Mode",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(totalNug.toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(total_avg_weigth.toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(
                                bottom: 2, top: 2, left: 10),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("BASIC AMT",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(total_bikri_amt.toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("OTHER CHARGES",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(total_other_charges.toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(
                                bottom: 2, top: 2, left: 10),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("TOTAL CHARGES",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("("+total_charges.toString()+") ",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child:  pw.Text("FREIGHT",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                           /* decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(total_freight_charges.toString(),
                              style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(
                                bottom: 2, top: 2, left: 10),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("TOTAL AMT",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Column(
                              children: [
                                pw.Divider(color: PdfColors.black,height: 5),
                                pw.Text(total_amt.toString(),
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                                pw.Divider(color: PdfColors.black,height: 5),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    left: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text("LABOUR",
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(bottom: 2, top: 2),
                            /*decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(color: PdfColors.grey),
                                    right: pw.BorderSide(color: PdfColors.grey))
                            ),*/
                            child: pw.Text(total_labour.toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }, itemCount: data.length)];
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
