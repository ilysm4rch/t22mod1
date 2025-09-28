import 'package:flutter/material.dart';

class TravelHome extends StatefulWidget {
  const TravelHome({super.key});

  @override
  TravelHomeState createState() => TravelHomeState();
}

class TravelHomeState extends State<TravelHome> with TickerProviderStateMixin {
  int bookingCount = 0;
  final List<Map<String, dynamic>> bookings = [];
  final List<Map<String, dynamic>> favorites = [];

  String searchQuery = "";

  void updateBookingCount() {
    setState(() {
      bookingCount = bookings.fold<int>(
        0,
        (sum, item) => sum + (item["quantity"] as int),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipPath(
                clipper: AppBarWaveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/bg-top.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 120,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search a destination',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF1E4D92),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF6F9FC),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E4D92),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E4D92),
                            width: 2,
                          ),
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
            child: Column(
              children: [
                // Tabs and content here
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Color(0xFF1E4D92),
                          unselectedLabelColor: Colors.black54,
                          indicatorColor: Color(0xFF1E4D92),
                          tabs: [
                            Tab(text: "Destinations"),
                            Tab(text: "Favorites"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              buildDestinations(context),
                              buildFavorites(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Destinations
  Widget buildDestinations(BuildContext context) {
    final List<Map<String, dynamic>> destinations = [
      {
        "place": "Paris",
        "price": 1200,
        "description": "The city of lights, love, and iconic Eiffel Tower.",
        "image": "assets/img/paris.png",
      },
      {
        "place": "Tokyo",
        "price": 1500,
        "description":
            "A blend of tradition and technology in Japan’s capital.",
        "image": "assets/img/tokyo.png",
      },
      {
        "place": "Bali",
        "price": 1000,
        "description": "A tropical paradise with beaches and temples.",
        "image": "assets/img/bali.png",
      },
      {
        "place": "New York",
        "price": 1300,
        "description": "The city that never sleeps, full of energy.",
        "image": "assets/img/newyork.png",
      },
    ];

    final filtered = destinations
        .where((d) => d["place"].toLowerCase().contains(searchQuery))
        .toList();

    return filtered.isEmpty
        ? const Center(
            child: Text(
              "No destinations found.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return buildDestinationCard(filtered[index]);
            },
          );
  }

  // Favorites Tab
  Widget buildFavorites() {
    final filtered = favorites
        .where((d) => d["place"].toLowerCase().contains(searchQuery))
        .toList();

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return buildDestinationCard(filtered[index]);
      },
    );
  }

  // Destination Card
  Widget buildDestinationCard(Map<String, dynamic> destination) {
    final isFavorite = favorites.any(
      (item) => item["place"] == destination["place"],
    );

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
              destination["image"],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
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
                    color: Color(0xFF1E4D92),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  destination["description"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  "\$${destination["price"]}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite button
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFFE63946),
                        size: 20,
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
                    // Booking button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E4D92),
                        minimumSize: const Size(60, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Book",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          bookings.add({
                            "place": destination["place"],
                            "price": destination["price"],
                            "quantity": 1,
                            "image": destination["image"],
                          });
                        });
                        updateBookingCount();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Booked a trip to ${destination["place"]}!",
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: const Color(0xFF1E4D92),
                          ),
                        );
                      },
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
