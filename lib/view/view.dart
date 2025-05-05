import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quik/controller/controller.dart';
import 'package:quik/view/webview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherScreen extends StatelessWidget {
  final UrlController urlController = Get.put(UrlController());

  Future<void> handleUrlLaunch(BuildContext context, String url) async {
    final List<String> openInBrowser = [
      "facebook.com",
      "zoom.us",
      "instagram.com",
      "linkedin.com",
      "wa.me",
      // "youtube.com",
      "twitter.com",
      "t.me",
      "reddit.com",
      "pinterest.com",
    ];

    final uri = Uri.parse(url);
    final shouldOpenInBrowser = openInBrowser.any(
      (domain) => uri.host.contains(domain),
    );

    if (shouldOpenInBrowser) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Launch Failed',
          'Could not open $url',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // Open in WebViewPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WebViewPage(url: url)),
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UrlLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        width: Get.width * 0.65,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade800),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.apps, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Qwik App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.white),
              title: Text('Share App', style: TextStyle(color: Colors.white)),
              onTap: () {
                Share.share(
                  'Check out Qwik App – a quick launcher for your favorite tools!',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Exit App', style: TextStyle(color: Colors.white)),
              onTap: () => urlController.showExitDialog(context),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.apps, color: Colors.black, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Qwik',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              onChanged: (value) => urlController.searchQuery.value = value,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search apps...',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.3),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {
        final filtered = urlController.filteredUrls;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              String title = filtered[index].key;
              var data = filtered[index].value;

              return GestureDetector(
                onTap:
                    () =>
                    // urlController.launchUrl(data['url']),
                    // _openInAppBrowser(context, data['url']),
                    handleUrlLaunch(context, data['url']),

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: data['color'],
                        radius: 20,
                        child: HugeIcon(
                          icon: data['icon'],
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Color.fromARGB(255, 241, 240, 240),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
