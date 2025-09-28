import 'package:flutter/material.dart';

import 'booking_form.dart';
import 'manage_booking.dart';
// You will also need to import 'main.dart' or the file that contains DestinationDetails
// If DestinationDetails is in main.dart, you need to import it. Assuming main.dart is TravelHome's file for now.
// Since you provided the full code for TravelHome, I'll include the necessary import for DestinationDetails.

// Import the file containing DestinationDetails. Assuming it's in a file named 'main.dart'
// based on the context, but since you provided the full class structure, 
// I'll assume you have a file with the DestinationDetails class definition.
// If your main.dart is structured like in the prompt, you would need to import it.
// For a standalone file, we must redefine or import it. For this example, I'll assume you have access.
// Since the prompt provided DestinationDetails, I'll put it here to make the file runnable.

// IMPORTANT: In a real Flutter project, if DestinationDetails is defined in the same file
// as TravelHome (which is often named main.dart), you would need to import it here.
// For the sake of providing a complete and correct Favorites.dart file, 
// I will include the DestinationDetails class definition that was in the main.dart file.

class DestinationDetails extends StatelessWidget {
  final Map<String, dynamic> destination;
  const DestinationDetails({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC143C),
        title: Text(destination["place"]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                destination["image"],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              destination["place"],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 16),
                const SizedBox(width: 4),
                Text(
                  destination["location"],
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(destination["description"]),
            const SizedBox(height: 16),
            const Text(
              "Inclusions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              (destination["inclusions"] as List).length,
              (i) => Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Text(destination["inclusions"][i]),
                ],
              ),
            ),
          ],
        ),
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

class Favorites extends StatefulWidget {
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  const Favorites({
    super.key,
    required this.favorites,
    required this.onRemoveFavorite,
  });

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  int selectedIndex = 0;
  final List<IconData> navIcons = [Icons.favorite, Icons.home, Icons.calendar_month];
  final List<Map<String, dynamic>> bookings = [];

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
            automaticallyImplyLeading: false, // Remove the leading back button
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 80),
              title: const Text(
                'FAVORITES',
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
                      image: AssetImage("assets/img/bg-top.jpg"),
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
          SliverFillRemaining(child: buildFavoritesList()),
        ],
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  // Navigation Bar
  Widget _navBar() {
    return Container(
      height: 55,
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

                  if (index == 1) {
                    Navigator.pop(context); // Changed from push to pop
                  } else if (index == 2) {
                    // Navigate to ManageBooking
                    // Need to correctly pass the bookings list.
                    // Since bookings is local to this state, a proper app state
                    // management solution would be better, but for this copy-paste
                    // scenario, we use the local list and a temporary callback.
                    // NOTE: This implementation of passing 'bookings' is temporary
                    // and won't reflect real bookings from TravelHome unless
                    // passed through arguments/state management.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageBooking(
                          bookings: bookings,
                          onRemoveBooking: (index) {
                            setState(() {
                              bookings.removeAt(index);
                            });
                          },
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

  Widget buildFavoritesList() {
    if (widget.favorites.isEmpty) {
      return const Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        // Adjusted aspect ratio to accommodate the new buttons
        childAspectRatio: 0.65, 
      ),
      itemCount: widget.favorites.length,
      itemBuilder: (context, index) {
        return buildDestinationCard(widget.favorites[index]);
      },
    );
  }

  Widget buildDestinationCard(Map<String, dynamic> destination) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack for Image and Favorite Icon (same as original card)
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  destination["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.favorite, // Always filled since it's in the favorites list
                      color: Color(0xFFE63946),
                    ),
                    onPressed: () {
                      widget.onRemoveFavorite(destination);
                    },
                  ),
                ),
              ),
            ],
          ),

          // Info and Buttons
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination["place"],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 4),
                // Location Row
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.red),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        destination["location"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "Tour Starts at ₱${destination["price"]}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Buttons Row (Copied from TravelHome card)
                Row(
                  children: [
                    Expanded(
                      // Details button
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDC143C)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          minimumSize: const Size(0, 30), // Smaller size for GridView item
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DestinationDetails(destination: destination),
                            ),
                          );
                        },
                        child: const Text(
                          "Details",
                          style: TextStyle(
                            color: Color(0xFFDC143C), 
                            fontSize: 12, // Smaller font size
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Add a small space between buttons
                    Expanded(
                      // Book button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC143C),
                          minimumSize: const Size(0, 30), // Smaller size for GridView item
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookForm(
                                destination: destination,
                                onBook: (booking) {
                                  setState(() {
                                    // The Favorites screen doesn't have the main bookings list
                                    // but we can add the new booking to its local list for demonstration/testing
                                    bookings.add({
                                      ...booking,
                                      'destination': {
                                        'place': destination['place'],
                                        'image': destination['image'],
                                      },
                                    });
                                  });
                                },
                              ),
                            ),
                          ).then((_) => setState(() {}));
                        },
                        child: const Text(
                          "Book",
                          style: TextStyle(
                            fontSize: 12, // Smaller font size
                            color: Colors.white,
                          ),
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
}