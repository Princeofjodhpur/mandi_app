import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key,required this.pdfPath});
  final pdfPath;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    print(widget.pdfPath);
    await _controller.initialize();
    await _controller.loadUrl(widget.pdfPath);
    // LISTEN DATA FROM HTML CONTENT
    _controller.webMessage.listen((event) {
      print(event);
    });
    if (!mounted) return;

    setState(() {});
  }

  Widget compositeView() {
    if (!_controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              Webview(_controller),
              StreamBuilder<LoadingState>(
                  stream: _controller.loadingState,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == LoadingState.loading) {
                      return LinearProgressIndicator();
                    } else {
                      return Container();
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 5),
                child: ElevatedButton(
                  onPressed: (){Navigator.pop(context);},
                  child: Text("Cancel",style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: compositeView(),
      ),
    );
  }
}
