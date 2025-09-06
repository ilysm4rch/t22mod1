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
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample orders with descriptions
    final List<Map<String, String>> orders = [
      {
        "item": "Espresso",
        "price": "₱100 – ₱180",
        "description": "Strong and bold shot of pure coffee."
      },
      {
        "item": "Americano",
        "price": "₱120 – ₱200",
        "description": "Espresso with added hot water, smooth taste."
      },
      {
        "item": "Cappuccino",
        "price": "₱140 – ₱220",
        "description": "Rich espresso topped with foamy milk."
      },
      {
        "item": "Latte",
        "price": "₱150 – ₱230",
        "description": "Espresso with steamed milk, creamy and light."
      },
      {
        "item": "Mocha",
        "price": "₱160 – ₱250",
        "description": "Espresso mixed with chocolate and milk."
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
          'Sample Café',
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
          // 📌 Image Container on top
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

          // 📌 Expanded Grid below the image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: orders.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    color: const Color(0xffedebdd),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color(0xff630100),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 👈 Align left
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order["item"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff630100),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${order["price"]}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
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

