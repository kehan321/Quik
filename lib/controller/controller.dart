import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlController extends GetxController {
  final searchQuery = ''.obs;
  final urls =
      <String, Map<String, dynamic>>{
        'YouTube': {
          'url': 'https://www.youtube.com',
          'icon': HugeIcons.strokeRoundedYoutube,
          'color': Colors.red,
        },
        'Facebook': {
          'url': 'https://www.facebook.com',
          'icon': Icons.facebook,
          'color': Colors.blue,
        },
        'WhatsApp': {
          'url': 'https://wa.me/1234567890',
          'icon': HugeIcons.strokeRoundedWhatsapp,
          'color': Colors.green,
        },
        'Google': {
          'url': 'https://www.google.com',
          'icon': HugeIcons.strokeRoundedGoogle,
          'color': Colors.orange,
        },
        'Twitter': {
          'url': 'https://twitter.com',
          'icon': HugeIcons.strokeRoundedTwitter,
          'color': Colors.lightBlue,
        },
        'Instagram': {
          'url': 'https://www.instagram.com',
          'icon': HugeIcons.strokeRoundedInstagram,
          'color': Colors.pink,
        },
        'LinkedIn': {
          'url': 'https://www.linkedin.com',
          'icon': HugeIcons.strokeRoundedLinkedin02,
          'color': Colors.blueAccent,
        },
        'GitHub': {
          'url': 'https://github.com',
          'icon': HugeIcons.strokeRoundedGithub,
          'color': Colors.black,
        },
        'Telegram': {
          'url': 'https://t.me/username', // Replace with your Telegram username
          'icon': HugeIcons.strokeRoundedTelegram,
          'color': Colors.blue,
        },
        'Reddit': {
          'url': 'https://www.reddit.com',
          'icon': Icons.reddit,
          'color': Colors.orangeAccent,
        },
        'Pinterest': {
          'url': 'https://www.pinterest.com',
          'icon': Icons.push_pin,
          'color': Colors.redAccent,
        },
        'Snapchat': {
          'url': 'https://www.snapchat.com',
          'icon': HugeIcons.strokeRoundedSnapchat,
          'color': Colors.yellow,
        },
        'TikTok': {
          'url': 'https://www.tiktok.com',
          'icon': Icons.music_note,
          'color': Colors.black,
        },
        'Amazon': {
          'url': 'https://www.amazon.com',
          'icon': Icons.shopping_cart,
          'color': Colors.orange,
        },
        'Netflix': {
          'url': 'https://www.netflix.com',
          'icon': HugeIcons.strokeRoundedFilm01,
          'color': Colors.redAccent,
        },
        'Spotify': {
          'url': 'https://www.spotify.com',
          'icon': Icons.music_note,
          'color': Colors.green,
        },
        'Zoom': {
          'url': 'https://zoom.us',
          'icon': Icons.video_call,
          'color': Colors.blueAccent,
        },
        'PayPal': {
          'url': 'https://www.paypal.com',
          'icon': Icons.payment,
          'color': Colors.indigo,
        },
        'Gmail': {
          'url': 'https://mail.google.com',
          'icon': Icons.mail,
          'color': Colors.red,
        },
        'Dropbox': {
          'url': 'https://www.dropbox.com',
          'icon': Icons.cloud,
          'color': Colors.blue,
        },

        'Medium': {
          'url': 'https://medium.com',
          'icon': Icons.book,
          'color': Colors.black,
        },
        'Flipkart': {
          'url': 'https://www.flipkart.com',
          'icon': Icons.store,
          'color': Colors.blueAccent,
        },
        'Uber': {
          'url': 'https://www.uber.com',
          'icon': Icons.local_taxi,
          'color': Colors.black,
        },
        'Swiggy': {
          'url': 'https://www.swiggy.com',
          'icon': Icons.restaurant_menu,
          'color': Colors.deepOrange,
        },
        'Zomato': {
          'url': 'https://www.zomato.com',
          'icon': Icons.fastfood,
          'color': Colors.redAccent,
        },
        'Quora': {
          'url': 'https://www.quora.com',
          'icon': Icons.question_answer,
          'color': Colors.red,
        },
        'Microsoft': {
          'url': 'https://www.microsoft.com',
          'icon': Icons.laptop_windows,
          'color': Colors.blueGrey,
        },
        'Yahoo': {
          'url': 'https://www.yahoo.com',
          'icon': Icons.web,
          'color': Colors.purple,
        },
      }.obs;

  List<MapEntry<String, Map<String, dynamic>>> get filteredUrls {
    if (searchQuery.value.isEmpty) {
      return urls.entries.toList();
    } else {
      return urls.entries
          .where(
            (entry) => entry.key.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }
  }

void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Exit App?"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }
  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        'Launch Failed',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }




}
