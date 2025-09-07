import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // List of menu items with details
    final List<Map<String, String>> orders = [
      {
        "item": "Espresso",
        "price": "₱100 – ₱180",
        "description": "A strong, concentrated shot of coffee with bold flavor and rich aroma.",
        "image": "assets/img/espresso.jpg"
      },
      {
        "item": "Americano",
        "price": "₱120 – ₱200",
        "description": "Espresso diluted with hot water, smooth and slightly lighter in taste.",
        "image": "assets/img/americano.jpg"
      },
      {
        "item": "Cappuccino",
        "price": "₱140 – ₱220",
        "description": "A balanced mix of espresso, steamed milk, and frothy foam.",
        "image": "assets/img/cappuccino.jpg"
      },
      {
        "item": "Latte",
        "price": "₱150 – ₱230",
        "description": "Creamy espresso drink with more steamed milk and a light layer of foam.",
        "image": "assets/img/latte.jpg"
      },
      {
        "item": "Mocha",
        "price": "₱160 – ₱250",
        "description": "A sweet blend of espresso, chocolate syrup, and steamed milk.",
        "image": "assets/img/mocha.jpg"
      },
      {
        "item": "Macchiato",
        "price": "₱160 – ₱250",
        "description": "Espresso with a touch of frothy milk.",
        "image": "assets/img/macchiato.jpg"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffedebdd),

      // 🧱 Top AppBar (Header Bar)
      appBar: AppBar(
        title: const Text(
          'Café Haven',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Caveat', // Custom font for branding
          ),
        ),
        backgroundColor: const Color(0xff630100), // Dark red coffee color
        centerTitle: true,
      ),

      // 📦 Main Content
      body: Column(
        children: [
          // 📸 Top Banner Image
          Container(
            height: 106,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("assets/img/top.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🧱 Expanded scrollable content (Grid + Footer)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final order = orders[index];

                        // 🧩 Individual Menu Card
                        return Card(
                          color: const Color(0xffedebdd), // Background color matches scaffold
                          elevation: 3, // Subtle shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Color(0xff630100), // Border matches theme
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // 📋 Main Content of the Card
                              Padding(
                                padding: const EdgeInsets.fromLTRB(11, 12, 11, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ☕ Coffee Image
                                    Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.brown[100],
                                        image: DecorationImage(
                                          image: AssetImage(order["image"] ?? "assets/img/default.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // 🏷️ Item Name
                                    Text(
                                      order["item"]!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff630100),
                                      ),
                                    ),
                                    const SizedBox(height: 0.1),

                                    // 💰 Price
                                    Text(
                                      order["price"]!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // 📝 Description
                                    Text(
                                      order["description"]!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 18), // Leaves space for the add button
                                  ],
                                ),
                              ),

                              // ➕ Add Button (Floating Circle Button)
                              Positioned(
                                bottom: 85,
                                right: 15,
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x42000000),
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff630100), // Match theme color
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add, color: Colors.white),
                                      onPressed: () {
                                        
                                      },
                                      iconSize: 24,
                                      splashRadius: 10,
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // 🦶 Footer inside scrollable area
                  Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 80, 2, 1),
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Branding and description
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Café Haven',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Caveat',
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                'Your cozy corner for specialty coffee and pastries.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // Location and contact
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 10),
                              Text(
                                'San Jose City, Nueva Ecija, Philippines, 3121',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Contact: (02) 1234-5678 | cafehaven.official.gmail.com',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // Copyright (separated)
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              SizedBox(height: 25),
                              Text(
                                '© 2025 Café Haven. All rights reserved.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Designed & developed by Café Haven Team.',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
