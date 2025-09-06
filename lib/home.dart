/* Columns - 2 */
// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Information Technology',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color: Colors.blueAccent[100],
//             padding: const EdgeInsets.all(20),
//             child: const Text(
//               'Welcome to the IT Department',
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//           ),
//           Container(
//             color: Colors.blueAccent[200],
//             padding: const EdgeInsets.all(20),
//             child: const Text(
//               'System Development and Network Management',
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



/* Rows - 2 */
// import 'package:flutter/material.dart';
// import 'package:t22mod1/sysdev.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Information Technology',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color: Colors.blueAccent[100],
//             padding: const EdgeInsets.all(20),
//             child: const Text(
//               'Welcome to the IT Department',
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//           ),
//           Container(
//             color: Colors.blueAccent[200],
//             padding: const EdgeInsets.all(20),
//             child: SysDev(),
//           ),
//         ],
//       ),
//     );
//   }
// }



/* Images - 1 */
// import 'package:flutter/material.dart';
// import 'package:test/sysdev.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Information Technology',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color: Colors.blueAccent[100],
//             padding: const EdgeInsets.all(20),
//             child: const Text(
//               'Welcome to the IT Department',
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//           ),
//           Container(
//             color: Colors.blueAccent[200],
//             padding: const EdgeInsets.all(20),
//             child: SysDev(),
//           ),
//         ],
//       ),
//     );
//   }
// }



/* Expanded Widgets */
/* Expanded Widgets */
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        "item": "Espresso",
        "price": "₱100 – ₱180",
        "description": "A strong, concentrated shot of coffee with bold flavor and rich aroma."
      },
      {
        "item": "Americano",
        "price": "₱120 – ₱200",
        "description": "Espresso diluted with hot water, smooth and slightly lighter in taste."
      },
      {
        "item": "Cappuccino",
        "price": "₱140 – ₱220",
        "description": "A balanced mix of espresso, steamed milk, and frothy foam."
      },
      {
        "item": "Latte",
        "price": "₱150 – ₱230",
        "description": "Creamy espresso drink with more steamed milk and a light layer of foam."
      },
      {
        "item": "Mocha",
        "price": "₱160 – ₱250",
        "description": "A sweet blend of espresso, chocolate syrup, and steamed milk."
      },
      {
        "item": "Macchiato",
        "price": "₱160 – ₱250",
        "description": "Espresso with a touch of frothy milk."
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffedebdd),
      appBar: AppBar(
        title: const Text(
          'Café Haven',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Caveat',
          ),
        ),
        backgroundColor: const Color(0xff630100),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // 📌 Top banner image
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
          

          // 📌 Expanded Grid (menu items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(11, 2, 11, 4),
              child: GridView.builder(
                itemCount: orders.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    color: const Color(0xffedebdd),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Color(0xff630100),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(11, 12, 11, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 🖼 Coffee image
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.brown[100],
                              image: const DecorationImage(
                                image: AssetImage("assets/img/sample_drink.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // ☕ Item name
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
                            "${order["price"]}",
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}









      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       color: const Color(0xffedebdd),
      //       padding: const EdgeInsets.all(20),
      //       child: const Text(
      //         'Welcome to the IT Department',
      //         style: TextStyle(fontSize: 20, color: Colors.white),
      //       ),
      //     ),
      //     Container(
      //       color: const Color(0xffedebdd),
      //       padding: const EdgeInsets.all(20),
      //       child: SysDev(),
      //     ),
      //     // Expanded(
      //     //   child: Image.asset('assets/img/bg.jpg',
      //     //     fit: BoxFit.fitWidth,
      //     //     alignment: Alignment.bottomCenter,
      //     //   ),
      //     // )
      //   ],
      // ),
//     );
//   }
// }

