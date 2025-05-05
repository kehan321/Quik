import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class QwikDrawerWidget extends StatelessWidget {
  final BuildContext context;
  final dynamic urlController;

  const QwikDrawerWidget({
    super.key,
    required this.context,
    required this.urlController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
