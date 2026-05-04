import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Remember to initialize Firebase here!
  runApp(JustSmileApp());
}

class JustSmileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple, scaffoldBackgroundColor: Color(0xFFF3E5F5)),
      home: CustomerDashboard(),
    );
  }
}

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  String? selectedPackage;
  File? _paymentImage;
  final picker = ImagePicker();

  // 1. DATA FROM YOUR PRICELIST IMAGE
  final List<Map<String, dynamic>> services = [
    {"name": "Simple Call", "price": 3000},
    {"name": "Apology Call", "price": 6000},
    {"name": "Yoruba Call & Eulogy", "price": 10000},
    {"name": "Special Call, Song & Text", "price": 5000},
    {"name": "International Call", "price": 6000},
  ];

  // 2. PAYMENT UPLOAD LOGIC
  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() { if (pickedFile != null) _paymentImage = File(pickedFile.path); });
  }

  // 3. SUBMIT ORDER TO FIREBASE (Verification Logic)
  Future _submitOrder() async {
    if (selectedPackage == null || _paymentImage == null) return;

    // Upload to Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('payments/$fileName');
    await ref.putFile(_paymentImage!);
    String downloadUrl = await ref.getDownloadURL();

    // Save to Firestore for Admin to verify
    await FirebaseFirestore.instance.collection('orders').add({
      'package': selectedPackage,
      'proof_url': downloadUrl,
      'status': 'pending', // Friend sees this as 'Pending' in Admin mode
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Submitted! Please wait for verification.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JUST SMILE 🌟")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select a Service:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...services.map((s) => RadioListTile(
              title: Text("${s['name']} (₦${s['price']})"),
              value: s['name'],
              groupValue: selectedPackage,
              onChanged: (val) => setState(() => selectedPackage = val as String),
            )).toList(),
            
            Divider(),
            
            Text("Step 2: Transfer to [Bank Name] - 0123456789", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 10),
            
            Center(
              child: Column(
                children: [
                  _paymentImage == null ? Icon(Icons.receipt_long, size: 100, color: Colors.grey) : Image.file(_image!, height: 150),
                  ElevatedButton(onPressed: _pickImage, child: Text("Upload Payment Screenshot")),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.purple),
              child: Text("Finalize Order", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}