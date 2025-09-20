import 'package:flutter/material.dart';
import 'order_summary.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    // List of menu items with details and desc
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: const [
                        Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3A1A0F),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Drinks",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
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

                        // Menu Cards
                        return Card(
                          color: const Color(0xFFF0f0f0),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image container with red background
                                Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFFB53324),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      order["image"] ??
                                          "assets/img/default.jpg",
                                      fit: BoxFit.cover,
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
                                        IconButton(
                                          icon: const Icon(
                                            Icons.favorite_border,
                                            color: Color(0xFFD98236),
                                            size: 20,
                                          ),
                                          onPressed: () {},
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        const SizedBox(width: 1),
                                        Container(
                                          width: 20, // set width
                                          height: 20, // set height (same as width for perfect circle)

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

                  // Footer
                  Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 80, 2, 1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 45,
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Café Haven',
                          style: TextStyle(
                            color: Color(0xffedebdd),
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Caveat',
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'San Jose City, Nueva Ecija, Philippines, 3121',
                          style: TextStyle(
                            color: Color(0xffedebdd),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Contact: (02) 1234-5678 | cafehaven.official@gmail.com',
                          style: TextStyle(
                            color: Color(0xffedebdd),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          '© 2025 Café Haven. All rights reserved.',
                          style: TextStyle(
                            color: Color(0xffedebdd),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Designed & developed by Bernabe, Libatique and Ocareza.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
}

void main() {
  runApp(const MaterialApp(home: Home()));
}
