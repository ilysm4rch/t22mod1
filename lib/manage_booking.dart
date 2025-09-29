import 'package:flutter/material.dart';
import 'favorites.dart';
import 'booking_form.dart';
import 'widgets/app_bottom_nav.dart';

class ManageBooking extends StatefulWidget {
  final List<Map<String, dynamic>> bookings;
  final Function(int) onRemoveBooking;
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  const ManageBooking({
    super.key,
    required this.bookings,
    required this.onRemoveBooking,
    required this.favorites,
    required this.onRemoveFavorite,
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
      bottomNavigationBar: AppBottomNavBar(
        icons: navIcons,
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Favorites(
                  favorites: widget.favorites,
                  onRemoveFavorite: widget.onRemoveFavorite,
                  bookings: widget.bookings,
                  onRemoveBooking: widget.onRemoveBooking,
                ),
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 2) {
            // Stay on Manage Booking; do a lightweight refresh
            setState(() {});
          }
        },
      ),
    );
  }

  Widget buildBookingsList() {
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

    // Render as a grid similar to Favorites
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.70,
      ),
      itemCount: widget.bookings.length,
      itemBuilder: (context, index) {
        try {
          final booking = widget.bookings[index];

          // Validate booking data structure
          if (!booking.containsKey('destination') ||
              booking['destination'] == null) {
            print('Invalid booking data at index $index: $booking');
            return const SizedBox.shrink();
          }

          // Validate destination data
          final destination = booking['destination'] as Map<String, dynamic>?;
          if (destination == null ||
              (destination['place'] == null && destination['image'] == null)) {
            // If absolutely no destination info, skip rendering this item
            print('Invalid destination data: $destination');
            return const SizedBox.shrink();
          }

          return buildBookingGridCard(booking, index);
        } catch (e) {
          print('Error building booking grid card at index $index: $e');
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildBookingGridCard(Map<String, dynamic> booking, int index) {
    final destination = booking['destination'] as Map<String, dynamic>?;
    if (destination == null) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              destination['image'] ?? 'assets/img/bg-top.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination['place'] ?? 'Unknown Location',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Arrival: ${booking['arrival'] ?? '—'}',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Departure: ${booking['departure'] ?? '—'}',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E4D92)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 0,
                          ),
                          minimumSize: const Size(0, 30),
                        ),
                        onPressed: () => showBookingDetails(booking),
                        child: const Text(
                          'View',
                          style: TextStyle(
                            color: Color(0xFF1E4D92),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC143C),
                          minimumSize: const Size(0, 30),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
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
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
                    // Use a known-existing fallback image
                    destination['image'] ?? 'assets/img/bg-top.jpg',
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
                        '[${((booking["destination"] as Map?)?["place"] ?? "Unknown Destination")}]',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E4D92),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ... existing buildDetailSection calls ...
                      buildDetailSection('PARTICIPANTS INFORMATION', [
                        ...(((booking['participants'] as List?)
                                    ?.cast<Map<String, dynamic>>() ??
                                const <Map<String, dynamic>>[]))
                            .asMap()
                            .entries
                            .map((entry) {
                              final participant = entry.value;
                              final firstName = participant['firstName'] ?? '';
                              final lastName = participant['lastName'] ?? '';
                              final age = participant['age'] ?? '—';
                              final gender = participant['gender'] ?? '—';
                              return """
PARTICIPANT ${entry.key + 1}
Full Name: $firstName $lastName
Age: $age
Gender: $gender""";
                            }),
                      ]),
                      buildDetailSection('CONTACT INFORMATION', [
                        'Full Name: ${((booking["contactInfo"] as Map?)?["firstName"] ?? '')} ${((booking["contactInfo"] as Map?)?["lastName"] ?? '')}',
                        'Complete Address: ${((booking["contactInfo"] as Map?)?["address"] ?? '—')}',
                        'Mobile Number: ${((booking["contactInfo"] as Map?)?["mobile"] ?? '—')}',
                        'E-mail Address: ${((booking["contactInfo"] as Map?)?["email"] ?? '—')}',
                      ]),
                      buildDetailSection('PAYMENT', [
                        'Sender\'s Full Name: ${((booking["payment"] as Map?)?["senderName"] ?? '—')}',
                        'Mode of Payment: ${((booking["payment"] as Map?)?["paymentMode"] ?? '—')}',
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
    final participants =
        ((booking['participants'] as List?)?.cast<Map<String, dynamic>>() ??
        <Map<String, dynamic>>[]);
    final participantControllers = participants
        .map(
          (participant) => {
            'firstName': TextEditingController(
              text: (participant['firstName'] ?? '').toString(),
            ),
            'lastName': TextEditingController(
              text: (participant['lastName'] ?? '').toString(),
            ),
            'age': TextEditingController(
              text: (participant['age']?.toString() ?? ''),
            ),
            'gender': TextEditingController(
              text: (participant['gender'] ?? '').toString(),
            ),
          },
        )
        .toList();

    final contactFirstNameController = TextEditingController(
      text: ((booking["contactInfo"] as Map?)?["firstName"] ?? '').toString(),
    );
    final contactLastNameController = TextEditingController(
      text: ((booking["contactInfo"] as Map?)?["lastName"] ?? '').toString(),
    );
    final addressController = TextEditingController(
      text: ((booking["contactInfo"] as Map?)?["address"] ?? '').toString(),
    );
    final mobileController = TextEditingController(
      text: ((booking["contactInfo"] as Map?)?["mobile"] ?? '').toString(),
    );
    final emailController = TextEditingController(
      text: ((booking["contactInfo"] as Map?)?["email"] ?? '').toString(),
    );
    final senderNameController = TextEditingController(
      text: ((booking["payment"] as Map?)?["senderName"] ?? '').toString(),
    );
    final paymentModeController = TextEditingController(
      text: ((booking["payment"] as Map?)?["paymentMode"] ?? '').toString(),
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
                // Ensure maps exist
                final contactInfo =
                    (booking['contactInfo'] as Map?) ??
                    (booking['contactInfo'] = <String, dynamic>{});
                final payment =
                    (booking['payment'] as Map?) ??
                    (booking['payment'] = <String, dynamic>{});

                // Update participants information
                for (var i = 0; i < participants.length; i++) {
                  final controllers = participantControllers[i];
                  participants[i]['firstName'] = controllers['firstName']!.text;
                  participants[i]['lastName'] = controllers['lastName']!.text;
                  participants[i]['age'] =
                      int.tryParse(controllers['age']!.text) ?? 0;
                  participants[i]['gender'] = controllers['gender']!.text;
                }
                // If original booking had no participants list, persist ours
                booking['participants'] = participants;

                // Update contact information
                contactInfo["firstName"] = contactFirstNameController.text;
                contactInfo["lastName"] = contactLastNameController.text;
                contactInfo["address"] = addressController.text;
                contactInfo["mobile"] = mobileController.text;
                contactInfo["email"] = emailController.text;

                // Update payment information
                payment["senderName"] = senderNameController.text;
                payment["paymentMode"] = paymentModeController.text;
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

  // _navBar removed: using AppBottomNavBar component
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
