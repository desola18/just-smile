// Simple Admin Dashboard Snippet
class AdminOrderReview extends StatelessWidget {
  final String screenshotUrl = "https://link-to-uploaded-image.com";
  final double expectedAmount = 5000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pending Orders")),
      body: Column(
        children: [
          Image.network(screenshotUrl), // She sees the proof here
          Text("Expected: ₦$expectedAmount", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _updateStatus("Declined"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Fake/Invalid"),
              ),
              ElevatedButton(
                onPressed: () => _updateStatus("Approved"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Approve Order"),
              ),
            ],
          )
        ],
      ),
    );
  }
}