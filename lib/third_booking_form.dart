import 'package:flutter/material.dart';

import 'fourth_booking_summary.dart';

class ThirdForm extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  final Function(Map<String, dynamic>) onBook;

  const ThirdForm({super.key, required this.bookingData, required this.onBook});

  @override
  State<ThirdForm> createState() => _ThirdFormState();
}

class _ThirdFormState extends State<ThirdForm> {
  final _formKey = GlobalKey<FormState>();
  bool _formSubmitted = false;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _senderNameController = TextEditingController();
  String? selectedPaymentMode;

  // Payment options
  final List<String> paymentModes = [
    'Credit Card',
    'Debit Card',
    'PayPal',
    'Bank Transfer',
    'GCash',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _senderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 80),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BOOKING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              background: ClipPath(
                clipper: AppBarWaveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/img/bg-top.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Form',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4D92),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4D92),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('First Name'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF7CAC9),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF7CAC9),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDC143C),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _formKey.currentState?.validate();
                                  });
                                },
                                validator: (value) {
                                  if (_formSubmitted &&
                                      (value == null || value.isEmpty)) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Last Name'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF7CAC9),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF7CAC9),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDC143C),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _formKey.currentState?.validate();
                                  });
                                },
                                validator: (value) {
                                  if (_formSubmitted &&
                                      (value == null || value.isEmpty)) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('Complete Address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDC143C),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState?.validate();
                        });
                      },
                      validator: (value) {
                        if (_formSubmitted &&
                            (value == null || value.isEmpty)) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text('Mobile Number'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDC143C),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState?.validate();
                        });
                      },
                      validator: (value) {
                        if (_formSubmitted &&
                            (value == null || value.isEmpty)) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text('Email Address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDC143C),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState?.validate();
                        });
                      },
                      validator: (value) {
                        if (_formSubmitted &&
                            (value == null || value.isEmpty)) {
                          return 'This field is required';
                        }
                        // Only validate email format if there's a value
                        if (value != null &&
                            value.isNotEmpty &&
                            !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4D92),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text("Sender's Full Name"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _senderNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFF7CAC9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDC143C),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState?.validate();
                        });
                      },
                      validator: (value) {
                        if (_formSubmitted &&
                            (value == null || value.isEmpty)) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text('Mode of Payment'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF7CAC9)),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedPaymentMode,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: InputBorder.none,
                        ),
                        hint: const Text('Select Payment Mode'),
                        items: paymentModes
                            .map(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPaymentMode = newValue;
                            _formKey.currentState?.validate();
                          });
                        },
                        validator: (value) {
                          if (_formSubmitted &&
                              (value == null || value.isEmpty)) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Buttons and page indicator remain the same but update the Next button's onPressed:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF7CAC9),
                            minimumSize: const Size(130, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDC143C),
                            minimumSize: const Size(130, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _formSubmitted = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              final updatedBookingData = {
                                ...widget.bookingData,
                                'contactInfo': {
                                  'firstName': _firstNameController.text,
                                  'lastName': _lastNameController.text,
                                  'address': _addressController.text,
                                  'mobile': _mobileController.text,
                                  'email': _emailController.text,
                                },
                                'payment': {
                                  'senderName': _senderNameController.text,
                                  'paymentMode': selectedPaymentMode,
                                },
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingSummary(
                                    bookingData: updatedBookingData,
                                    onBook: widget.onBook,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Page indicator dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 2
                                ? const Color(0xFFDC143C)
                                : const Color(0xFFF7CAC9),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.0003667, size.height * 0.8100800);
    path.quadraticBezierTo(
      size.width * 0.1236444,
      size.height * 0.6845400,
      size.width * 0.2444111,
      size.height * 0.8500200,
    );
    path.cubicTo(
      size.width * 0.3334778,
      size.height * 0.7877200,
      size.width * 0.4082444,
      size.height * 0.8200800,
      size.width * 0.4643889,
      size.height * 0.9200000,
    );
    path.cubicTo(
      size.width * 0.5266111,
      size.height * 0.7738200,
      size.width * 0.7073333,
      size.height * 0.7294200,
      size.width * 0.7873333,
      size.height * 0.8234200,
    );
    path.quadraticBezierTo(
      size.width * 0.8718444,
      size.height * 0.6790800,
      size.width * 1.0003444,
      size.height * 0.7259800,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
