import 'package:flutter/material.dart';
import 'favorites.dart';
import 'booking_form.dart';

class ManageBooking extends StatefulWidget {
  final List<Map<String, dynamic>> bookings;
  final Function(int) onRemoveBooking;

  const ManageBooking({
    super.key,
    required this.bookings,
    required this.onRemoveBooking,
  });

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  int selectedIndex = 2;
  final List<IconData> navIcons = [
    Icons.favorite,
    Icons.home,
    Icons.calendar_month,
  ];

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
              title: const Text(
                'MANAGE \nBOOKING',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
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
          SliverFillRemaining(child: buildBookingsList()),
        ],
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget buildBookingsList() {
    print(
      'Building bookings list with ${widget.bookings.length} bookings',
    ); // Debug print

    if (widget.bookings.isEmpty) {
      return const Center(
        child: Text(
          "No bookings yet.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.bookings.length,
      itemBuilder: (context, index) {
        try {
          final booking = widget.bookings[index];

          // Validate booking data structure
          if (!booking.containsKey('destination') ||
              booking['destination'] == null) {
            print(
              'Invalid booking data at index $index: $booking',
            ); // Debug print
            return const SizedBox.shrink();
          }

          // Validate destination data
          final destination = booking['destination'] as Map<String, dynamic>?;
          if (destination == null ||
              !destination.containsKey('place') ||
              !destination.containsKey('image')) {
            print('Invalid destination data: $destination'); // Debug print
            return const SizedBox.shrink();
          }

          return buildBookingCard(booking, index);
        } catch (e) {
          print(
            'Error building booking card at index $index: $e',
          ); // Debug print
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildBookingCard(Map<String, dynamic> booking, int index) {
    // Add null checks for required data
    final destination = booking['destination'] as Map<String, dynamic>?;
    if (destination == null) {
      print('Warning: Booking destination is null'); // Debug print
      return const SizedBox.shrink(); // Return empty widget if data is invalid
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left side - Image
              SizedBox(
                width: 130,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                  child: Image.asset(
                    destination['image'] ?? 'assets/img/placeholder.jpg',
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Right side - Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        destination['place'] ?? 'Unknown Location',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E4D92),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Arrival: ${booking['arrival'] ?? 'Not specified'}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Departure: ${booking['departure'] ?? 'Not specified'}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${booking['adults'] ?? 0} Adults, ${booking['kids'] ?? 0} Kids",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E4D92),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookForm(
                                      destination: destination,
                                      onBook: (_) {},
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "View Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDC143C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              onPressed: () {
                                // Show confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Cancel Booking'),
                                    content: const Text(
                                      'Are you sure you want to cancel this booking?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          widget.onRemoveBooking(index);
                                          setState(() {}); // Trigger rebuild
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        // Change from AlertDialog to Dialog for more control
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Booking FormSummary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF1E4D92),
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showEditDialog(booking);
                      },
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '[${booking["destination"]["place"]}]',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E4D92),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ... existing buildDetailSection calls ...
                      buildDetailSection('PARTICIPANTS INFORMATION', [
                        ...(booking['participants']
                                as List<Map<String, dynamic>>)
                            .asMap()
                            .entries
                            .map((entry) {
                              final participant = entry.value;
                              return """
PARTICIPANT ${entry.key + 1}
Full Name: ${participant['firstName']} ${participant['lastName']}
Age: ${participant['age']}
Gender: ${participant['gender']}""";
                            }),
                      ]),
                      buildDetailSection('CONTACT INFORMATION', [
                        'Full Name: ${booking["contactInfo"]["firstName"]} ${booking["contactInfo"]["lastName"]}',
                        'Complete Address: ${booking["contactInfo"]["address"]}',
                        'Mobile Number: ${booking["contactInfo"]["mobile"]}',
                        'E-mail Address: ${booking["contactInfo"]["email"]}',
                      ]),
                      buildDetailSection('PAYMENT', [
                        'Sender\'s Full Name: ${booking["payment"]["senderName"]}',
                        'Mode of Payment: ${booking["payment"]["paymentMode"]}',
                      ]),
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEditDialog(Map<String, dynamic> booking) {
    // Controllers for all editable fields
    final participants = booking['participants'] as List<Map<String, dynamic>>;
    final participantControllers = participants
        .map(
          (participant) => {
            'firstName': TextEditingController(text: participant['firstName']),
            'lastName': TextEditingController(text: participant['lastName']),
            'age': TextEditingController(text: participant['age'].toString()),
            'gender': TextEditingController(text: participant['gender']),
          },
        )
        .toList();

    final contactFirstNameController = TextEditingController(
      text: booking["contactInfo"]["firstName"],
    );
    final contactLastNameController = TextEditingController(
      text: booking["contactInfo"]["lastName"],
    );
    final addressController = TextEditingController(
      text: booking["contactInfo"]["address"],
    );
    final mobileController = TextEditingController(
      text: booking["contactInfo"]["mobile"],
    );
    final emailController = TextEditingController(
      text: booking["contactInfo"]["email"],
    );
    final senderNameController = TextEditingController(
      text: booking["payment"]["senderName"],
    );
    final paymentModeController = TextEditingController(
      text: booking["payment"]["paymentMode"],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Booking'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...participants.asMap().entries.map((entry) {
                final index = entry.key;
                final controllers = participantControllers[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PARTICIPANT ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4D92),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller:
                          controllers['firstName'] as TextEditingController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextField(
                      controller:
                          controllers['lastName'] as TextEditingController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: controllers['age'] as TextEditingController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller:
                          controllers['gender'] as TextEditingController,
                      decoration: const InputDecoration(labelText: 'Gender'),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
              const Text(
                'CONTACT INFORMATION',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E4D92),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contactFirstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: contactLastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Complete Address',
                ),
                maxLines: 2,
              ),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const Text(
                'PAYMENT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E4D92),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: senderNameController,
                decoration: const InputDecoration(
                  labelText: 'Sender\'s Full Name',
                ),
              ),
              TextField(
                controller: paymentModeController,
                decoration: const InputDecoration(labelText: 'Mode of Payment'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E4D92),
            ),
            onPressed: () {
              setState(() {
                // Update participants information
                for (var i = 0; i < participants.length; i++) {
                  final controllers = participantControllers[i];
                  participants[i]['firstName'] = controllers['firstName']!.text;
                  participants[i]['lastName'] = controllers['lastName']!.text;
                  participants[i]['age'] = int.parse(controllers['age']!.text);
                  participants[i]['gender'] = controllers['gender']!.text;
                }

                // Update contact information
                booking["contactInfo"]["firstName"] =
                    contactFirstNameController.text;
                booking["contactInfo"]["lastName"] =
                    contactLastNameController.text;
                booking["contactInfo"]["address"] = addressController.text;
                booking["contactInfo"]["mobile"] = mobileController.text;
                booking["contactInfo"]["email"] = emailController.text;

                // Update payment information
                booking["payment"]["senderName"] = senderNameController.text;
                booking["payment"]["paymentMode"] = paymentModeController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildDetailSection(String title, List<String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E4D92),
          ),
        ),
        ...details.map(
          (detail) => Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(detail),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _navBar() {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7CAC9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navIcons.asMap().entries.map((entry) {
          int index = entry.key;
          IconData icon = entry.value;
          bool isSelected = selectedIndex == index;

          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  if (index == 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorites(
                          favorites: const [],
                          onRemoveFavorite: (destination) {},
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else if (index == 2) {
                    // Re-fetch bookings from main screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageBooking(
                          bookings: widget.bookings,
                          onRemoveBooking: widget.onRemoveBooking,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Icon(
                    icon,
                    size: 30,
                    color: isSelected
                        ? const Color(0xFFDC143C)
                        : const Color(0xFFF75270),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
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
