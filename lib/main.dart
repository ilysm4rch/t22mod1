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

  String searchQuery = "";

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
              if (cartCount > 0)
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

      body: SingleChildScrollView(
        child: Column(
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
                        fontFamily: "Caveat",
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for coffee...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFB53324)),
                  filled: true,
                  fillColor: Color(0xFFFFFAF4),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xFFB53324), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xFFB53324), width: 2),
                  ),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              ),
            ),

            // ✅ Tabs
            DefaultTabController(
              length: 2,
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
                  SizedBox(
                    height: 720,
                    child: TabBarView(
                      children: [
                        buildMenuContent(context),
                        // Favorites Tab with search filter
                        searchQuery.isNotEmpty
                            ? (favorites.where((item) =>
                                  item["item"].toLowerCase().contains(searchQuery)).isEmpty
                                ? const Center(
                                    child: Text(
                                      "No coffee match.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
                                    itemCount: favorites
                                        .where((item) => item["item"]
                                            .toLowerCase()
                                            .contains(searchQuery))
                                        .length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.65,
                                    ),
                                    itemBuilder: (context, index) {
                                      final filteredFavorites = favorites
                                          .where((item) => item["item"]
                                              .toLowerCase()
                                              .contains(searchQuery))
                                          .toList();
                                      return buildDrinkCard(context, filteredFavorites[index]);
                                    },
                                  ))
                            : (favorites.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No favorites yet.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
                                    itemCount: favorites.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.65,
                                    ),
                                    itemBuilder: (context, index) {
                                      return buildDrinkCard(context, favorites[index]);
                                    },
                                  )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFB53324).withOpacity(0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "café haven",
                    style: TextStyle(
                      fontFamily: "Caveat",
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB53324),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "123 Coffee Street, Brewtown\n📞 (0912) 345-6789\n✉️ cafehaven@email.com",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Menu Content
  Widget buildMenuContent(BuildContext context) {
    final List<Map<String, dynamic>> hotDrinks = [
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

    final List<Map<String, dynamic>> coldDrinks = [
      {
        "item": "Iced Americano",
        "prices": {"S": 110, "M": 130, "L": 150},
        "description": "Chilled espresso diluted with cold water and ice.",
        "image": "assets/img/IcedAmericano.png",
      },
      {
        "item": "Iced Latte",
        "prices": {"S": 140, "M": 160, "L": 180},
        "description": "Smooth espresso poured over cold milk and ice.",
        "image": "assets/img/IcedLatte.png",
      },
      {
        "item": "Cold Brew",
        "prices": {"S": 150, "M": 170, "L": 190},
        "description": "Slow-steeped coffee for a smoother, less acidic taste.",
        "image": "assets/img/ColdBrew.png",
      },
      {
        "item": "Frappe",
        "prices": {"S": 160, "M": 180, "L": 200},
        "description": "Blended iced coffee topped with whipped cream.",
        "image": "assets/img/Frappe.png",
      },
    ];

    // Filter drinks based on searchQuery
    final filteredHotDrinks = hotDrinks.where((drink) =>
      drink["item"].toLowerCase().contains(searchQuery)
    ).toList();

    final filteredColdDrinks = coldDrinks.where((drink) =>
      drink["item"].toLowerCase().contains(searchQuery)
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔥 Hot Coffee
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            "Hot Coffee",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2d0d0a),
            ),
          ),
        ),
        filteredHotDrinks.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'No coffee match.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredHotDrinks.length,
                  itemBuilder: (context, index) {
                    return buildDrinkCard(context, filteredHotDrinks[index]);
                  },
                ),
              ),

        // ❄️ Cold Coffee
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            "Cold Coffee",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2d0d0a),
            ),
          ),
        ),
        filteredColdDrinks.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'No coffee match.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredColdDrinks.length,
                  itemBuilder: (context, index) {
                    return buildDrinkCard(context, filteredColdDrinks[index]);
                  },
                ),
              ),
      ],
    );
  }

  // ✅ Drink Card
  Widget buildDrinkCard(BuildContext context, Map<String, dynamic> order) {
    final isFavorite =
        favorites.any((item) => item["item"] == order["item"]);
    String selectedSize = "S";

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return Container(
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            color: const Color(0xFFF0f0f0),
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
                    height: 120,
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

                  const SizedBox(height: 20),

                  // Coffee name
                  Text(
                    order["item"],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A1A0F),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Sizes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: ["S", "M", "L"].map((size) {
                      return GestureDetector(
                        onTap: () {
                          setInnerState(() {
                            selectedSize = size;
                          });
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: selectedSize == size
                                  ? const Color(0xFFD98236)
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 6),

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

                  const Spacer(),

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

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'You added ${order["item"]} ($selectedSize)!'),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor:
                                        const Color(0xFFB53324),
                                    behavior:
                                        SnackBarBehavior.floating,
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
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Home()));
}
