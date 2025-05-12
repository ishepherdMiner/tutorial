import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('tel://10000');

void main() => runApp(
  const MaterialApp(
    home: Material(
      child: Center(
        child: ElevatedButton(
          onPressed: _launchUrl,
          child: Text('Show Flutter homepage'),
        ),
      ),
    ),
  ),
);

Future<void> _launchUrl() async {
  if (await canLaunchUrl(_url)) {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
