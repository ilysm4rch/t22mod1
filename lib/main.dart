import 'package:flutter/material.dart';
import 'order_summary.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  int cartCount = 0;
  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> favorites = [];

  void updateCartCount() {
    setState(() {
      cartCount = cartItems.fold<int>(
        0,
        (sum, item) => sum + (item["quantity"] as int),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        "item": "Espresso",
        "prices": {"S": 100, "M": 120, "L": 140},
        "description":
            "A strong, concentrated shot of coffee with bold flavor and rich aroma.",
        "image": "assets/img/Espresso.png",
      },
      {
        "item": "Americano",
        "prices": {"S": 120, "M": 140, "L": 160},
        "description":
            "Espresso diluted with hot water, smooth and slightly lighter in taste.",
        "image": "assets/img/Americano.png",
      },
      {
        "item": "Cappuccino",
        "prices": {"S": 140, "M": 160, "L": 180},
        "description":
            "A balanced mix of espresso, steamed milk, and frothy foam.",
        "image": "assets/img/Cappuccino.png",
      },
      {
        "item": "Latte",
        "prices": {"S": 150, "M": 170, "L": 190},
        "description":
            "Creamy espresso drink with more steamed milk and a light layer of foam.",
        "image": "assets/img/Latte.png",
      },
      {
        "item": "Mocha",
        "prices": {"S": 160, "M": 180, "L": 200},
        "description":
            "A sweet blend of espresso, chocolate syrup, and steamed milk.",
        "image": "assets/img/Mocha.png",
      },
      {
        "item": "Macchiato",
        "prices": {"S": 160, "M": 180, "L": 200},
        "description": "Espresso with a touch of frothy milk.",
        "image": "assets/img/Macchiato.png",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),

      appBar: AppBar(
        title: const Text(
          'cafe haven',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Caveat",
            fontSize: 35,
            color: Color(0xFFB53324),
          ),
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        centerTitle: true,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_basket),
                color: const Color(0xFFB53324),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummary(
                        cartItems: cartItems,
                        onCartUpdated: updateCartCount,
                      ),
                    ),
                  );
                  updateCartCount();
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

      body: Column(
        children: [
          // ✅ Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(30),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFB53324),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "cafe haven!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Caveat", // ✅ Caveat font applied
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tabs
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Color(0xFFB53324),
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Color(0xFFB53324),
                    tabs: [
                      Tab(text: "Drinks"),
                      Tab(text: "Favorites"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildMenuContent(context, orders),
                        favorites.isEmpty
                            ? const Center(
                                child: Text(
                                  "No favorites yet.",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              )
                            : buildMenuContent(context, favorites),
                      ],
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

  Widget buildMenuContent(
      BuildContext context, List<Map<String, dynamic>> items) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final order = items[index];
            final isFavorite =
                favorites.any((item) => item["item"] == order["item"]);

            String selectedSize = "S";

            return StatefulBuilder(
              builder: (context, setInnerState) {
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
                        // Image
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
                                order["image"] ?? "assets/img/default.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        // Yellow line
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order["item"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A1A0F),
                              ),
                            ),
                            Row(
                              children: ["S", "M", "L"].map((size) {
                                return GestureDetector(
                                  onTap: () {
                                    setInnerState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: selectedSize == size
                                            ? const Color(0xFFB53324)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),

                        // Description
                        Text(
                          order["description"],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),

                        // Price + buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₱${order["prices"][selectedSize]}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
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
                                            item["item"] == order["item"]);
                                      } else {
                                        favorites.add(order);
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 1),
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
                                        cartItems.add({
                                          "item": order["item"],
                                          "price":
                                              order["prices"][selectedSize],
                                          "quantity": 1,
                                          "image": order["image"],
                                          "size": selectedSize,
                                        });
                                      });
                                      updateCartCount();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'You added ${order["item"]} ($selectedSize)!'),
                                          duration:
                                              const Duration(seconds: 2),
                                          backgroundColor:
                                              const Color(0xFFB53324),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
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
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Home()));
}
