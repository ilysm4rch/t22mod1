import 'package:flutter/material.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => OrderSummaryState();
}

class OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedebdd),

      // Header Bar
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff630100),
        centerTitle: true,
      ),
    );
  }
}
