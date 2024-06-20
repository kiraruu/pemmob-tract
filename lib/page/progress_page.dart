import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tract/components/my_receipt.dart';
import 'package:tract/models/hotel_restaurant.dart';
import 'package:tract/services/database/firestore.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  // get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

      // submit order to db
      String receipt = context.read<Restaurant>().displayCartReceipt();
      db.saveOrderToDatabase(receipt);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your payment in progress.."),
        backgroundColor: Colors.transparent,
      ),
      // bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          MyReceipt(),
        ],
      ),
    );
  }
}
