import 'package:flutter/material.dart';

import 'favorites.dart';
import 'booking_form.dart';
import 'manage_booking.dart';

class TravelHome extends StatefulWidget {
  const TravelHome({super.key});

  @override
  TravelHomeState createState() => TravelHomeState();
}

List<IconData> navIcons = [Icons.favorite, Icons.home, Icons.calendar_month];

class TravelHomeState extends State<TravelHome> with TickerProviderStateMixin {
  int selectedIndex = 1;
  final List<Map<String, dynamic>> bookings = [];
  final List<Map<String, dynamic>> favorites = [];

  String searchQuery = "";
  String selectedTag = "All";

  final List<String> tags = ["All", "City", "Beach", "Cultural", "Adventure"];

  final List<Map<String, dynamic>> destinations = [
    {
      "place": "Siargao",
      "price": 10000,
      "location": "Siargao, Philippines",
      "description":
          "Discover the beauty of ganito ganyan! Kaunting description here.",
      "image": "assets/img/bali.png",
      "tag": "Beach",
    },
    {
      "place": "Tokyo",
      "price": 12000,
      "location": "Tokyo, Japan",
      "description": "A blend of tradition and modern life.",
      "image": "assets/img/tokyo.png",
      "tag": "Cultural",
    },
    {
      "place": "Paris",
      "price": 15000,
      "location": "Paris, France",
      "description": "The city of lights, romance, and the Eiffel Tower.",
      "image": "assets/img/paris.png",
      "tag": "City",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipPath(
                clipper: AppBarWaveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/bg-top.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 120,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search destination',
                        hintStyle: const TextStyle(fontSize: 14),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.red,
                          size: 20,
                        ),
                        filled: true,
                        // ignore: deprecated_member_use
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 5,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query.toLowerCase();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discover
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      "Discover",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Tags row
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tags.length,
                      itemBuilder: (context, index) {
                        final tag = tags[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              child: Text(tag),
                            ),
                            selected: selectedTag == tag,
                            selectedColor: const Color(0xFFDC143C),
                            backgroundColor: const Color(0xFFF7CAC9),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: selectedTag == tag
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onSelected: (_) {
                              setState(() => selectedTag = tag);
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Best Deals
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      "Best Deals",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildHorizontalCardList("Best"),

                  const SizedBox(height: 20),

                  // Local Destinations
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      "Local Destinations",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildHorizontalCardList("Local"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  // Bottom Nav
  Widget _navBar() {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7CAC9),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navIcons.map((icon) {
          int index = navIcons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favorites(
                      favorites: favorites,
                      onRemoveFavorite: (destination) {
                        setState(() {
                          favorites.removeWhere(
                            (item) => item["place"] == destination["place"],
                          );
                        });
                      },
                    ),
                  ),
                ).then((_) => setState(() => selectedIndex = 1));
              } else if (index == 2) {
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
                ).then((_) => setState(() => selectedIndex = 1));
              }
            },
            icon: Icon(
              icon,
              size: 30,
              color: isSelected
                  ? const Color(0xFFDC143C)
                  : const Color(0xFFF75270),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Horizontal card list
  Widget buildHorizontalCardList(String section) {
    final filtered = destinations.where((d) {
      final matchesTag = selectedTag == "All" || d["tag"] == selectedTag;
      return matchesTag;
    }).toList();

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: buildDestinationCard(filtered[index]),
          );
        },
      ),
    );
  }

  // Card design
  Widget buildDestinationCard(Map<String, dynamic> destination) {
    final isFavorite = favorites.any(
      (item) => item["place"] == destination["place"],
    );

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
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
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: const Color(0xFFE63946),
                    ),
                    onPressed: () {
                      setState(() {
                        if (isFavorite) {
                          favorites.removeWhere(
                            (item) => item["place"] == destination["place"],
                          );
                        } else {
                          favorites.add(destination);
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name of Tourist Attraction",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
                const SizedBox(height: 8),
                Text(
                  "Tour Starts at ₱${destination["price"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(80, 32),
                        side: const BorderSide(color: Color(0xFFDC143C)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "View Details",
                        style: TextStyle(color: Color(0xFFDC143C)),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC143C),
                        minimumSize: const Size(80, 32),
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
                                  bookings.add({
                                    ...booking,
                                    'destination': {
                                      'place': destination['place'],
                                      'image': destination['image'],
                                    },
                                  });
                                  // ignore: avoid_print
                                  print(
                                    'Booking added: ${bookings.length}',
                                  ); // Debug print
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text("Book Now"),
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

void main() {
  runApp(const MaterialApp(home: TravelHome()));
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
