import 'package:flutter/material.dart';

class SecondForm extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  final Function(Map<String, dynamic>) onBook;

  const SecondForm({
    super.key,
    required this.bookingData,
    required this.onBook,
  });

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
