import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hugeicons/hugeicons.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  double top = 5;
  double left = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(
                  widget.url,
                ), // Convert the string URL to WebUri here
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                // Optionally handle WebView creation here
              },
              onLoadStart: (InAppWebViewController controller, WebUri? url) {
                print("Started loading: $url");
              },
              onLoadStop: (InAppWebViewController controller, WebUri? url) {
                print("Finished loading: $url");
              },
              onProgressChanged: (
                InAppWebViewController controller,
                int progress,
              ) {
                print("Loading progress: $progress%");
              },
            ),
            // Draggable back button
            Positioned(
              top: top,
              left: left,
              child: Draggable(
                feedback: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeftDouble,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                childWhenDragging:
                    Container(),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeftDouble,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onDragUpdate: (details) {
                  setState(() {
                    top = details.localPosition.dy;
                    left = details.localPosition.dx;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
