import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(JustSmileApp());

class JustSmileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Simple list for demonstration
  final List<Map<String, String>> packages = [
    {"name": "Mother's Day Special", "price": "₦12,000", "type": "Special"},
    {"name": "Standard Smile Box", "price": "₦5,000", "type": "Regular"},
    {"name": "Premium Celebration", "price": "₦25,000", "type": "Regular"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JUST SMILE 🌟")),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final item = packages[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: item['type'] == 'Special' ? Colors.pink[50] : Colors.white,
            child: ListTile(
              title: Text(item['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['price']!),
              trailing: ElevatedButton(
                onPressed: () => _launchURL("https://your-website-link.com"),
                child: Text("ORDER"),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to open the payment/form link
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}