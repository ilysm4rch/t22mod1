import 'package:flutter/material.dart';
import 'order_summary.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int cartCount = 0;
  List<Map<String, String>> favorites = []; // ❤️ favorites list

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        "item": "Espresso",
        "price": "₱100 – ₱180",
        "description":
            "A strong, concentrated shot of coffee with bold flavor and rich aroma.",
        "image": "assets/img/Espresso.png",
      },
      {
        "item": "Americano",
        "price": "₱120 – ₱200",
        "description":
            "Espresso diluted with hot water, smooth and slightly lighter in taste.",
        "image": "assets/img/Americano.png",
      },
      {
        "item": "Cappuccino",
        "price": "₱140 – ₱220",
        "description":
            "A balanced mix of espresso, steamed milk, and frothy foam.",
        "image": "assets/img/Cappuccino.png",
      },
      {
        "item": "Latte",
        "price": "₱150 – ₱230",
        "description":
            "Creamy espresso drink with more steamed milk and a light layer of foam.",
        "image": "assets/img/Latte.png",
      },
      {
        "item": "Mocha",
        "price": "₱160 – ₱250",
        "description":
            "A sweet blend of espresso, chocolate syrup, and steamed milk.",
        "image": "assets/img/Mocha.png",
      },
      {
        "item": "Macchiato",
        "price": "₱160 – ₱250",
        "description": "Espresso with a touch of frothy milk.",
        "image": "assets/img/Macchiato.png",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),

      // Header Bar
      appBar: AppBar(
        title: const Text(
          'cafe haven',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB53324),
          ),
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFB53324)),
          onPressed: () {},
        ),
        actions: [
          // ❤️ Favorites button
          IconButton(
            icon: const Icon(Icons.favorite, color: Color(0xFFB53324)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(favorites: favorites),
                ),
              );
            },
          ),

          // 🛒 Cart button
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_basket),
                color: const Color(0xFFB53324),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderSummary()),
                  );
                },
              ),
              Positioned(
                right: 3,
                top: 1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB53324),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // Main Content
      body: Column(
        children: [
          // Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(20),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFB53324),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "welcome to\ncafe haven!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Menu",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2d0d0a),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Drinks",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2d0d0a),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Menu Grid
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 40,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final isFavorite =
                            favorites.any((item) => item["item"] == order["item"]);

                        // Menu Cards
                        return Card(
                          color: const Color(0xFFF0f0f0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image container
                                Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFFB53324),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset(
                                        order["image"] ??
                                            "assets/img/default.jpg",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),

                                // 🔽 Yellow line
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    height: 4,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFe5a657),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Coffee name + sizes
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order["item"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3A1A0F),
                                      ),
                                    ),
                                    const Text(
                                      "S  M  L",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),

                                // Description
                                Text(
                                  order["description"]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),

                                // Price + action buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order["price"]!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // ❤️ Favorite button
                                        IconButton(
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: const Color(0xFFD98236),
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (isFavorite) {
                                                favorites.removeWhere((item) =>
                                                    item["item"] ==
                                                    order["item"]);
                                              } else {
                                                favorites.add(order);
                                              }
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),

                                        const SizedBox(width: 1),
                                        // ➕ Add button
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFB53324),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                cartCount++;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'You ordered ${order["item"]}!'),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  backgroundColor:
                                                      const Color(0xFF630100),
                                                  behavior: SnackBarBehavior
                                                      .floating,
                                                ),
                                              );
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints:
                                                const BoxConstraints(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ❤️ Favorites Page
class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites",
            style: TextStyle(color: Color(0xFFB53324))),
        backgroundColor: const Color(0xFFFFFAF4),
        iconTheme: const IconThemeData(color: Color(0xFFB53324)),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet! ❤️"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final fav = favorites[index];
                return ListTile(
                  leading: Image.asset(fav["image"]!,
                      width: 40, height: 40, fit: BoxFit.contain),
                  title: Text(fav["item"]!),
                  subtitle: Text(fav["price"]!),
                );
              },
            ),
    );
  }
}
