// Admin Notification Listener
FirebaseFirestore.instance
    .collection('orders')
    .where('status', isEqualTo = 'pending')
    .snapshots()
    .listen((snapshot) {
      if (snapshot.docChanges.isNotEmpty) {
        // This triggers a sound/alert on her phone
        triggerAdminAlert("New Payment Proof Received! Check now.");
      }
    });