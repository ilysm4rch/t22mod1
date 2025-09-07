/* MaterialApp */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Text('Hello')
//     )
//   );
// }



/* Scaffold */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Information Technology',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: Colors.blueAccent,
//           centerTitle: true,
//         ),
//         body: const Center(
//           child: Text(
//             'Hello World!',
//             style: TextStyle(
//               fontSize: 40,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }



/* Hot Reload */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Information Technology',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//         ),
//         body: const Home(),
//       ),
//     ),
//   );
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Hello World!!!',
//         style: TextStyle(
//           fontSize: 40,
//           color: Colors.black,
//         ),
//       )
//     );
//   }
// }



/* Container */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Information Technology',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//         ),
//         body: const Home(),
//       ),
//     ),
//   );
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blueGrey,
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.fromLTRB(10, 40, 0, 0),
//       child: const Text(
//         'Hello World!!!',
//         style: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//           decoration: TextDecoration.underline,
//           fontStyle: FontStyle.italic,
//           letterSpacing: 4,
//         ),
//       ),
//     );
//   }
// }



/* Columns - 1 */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: Sandbox()));
// }

// class Sandbox extends StatelessWidget {
//   const Sandbox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sandbox'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             width: 100,
//             color: Colors.black87,
//             child: const Text(
//               'Container 1',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//           Container(
//             width: 200,
//             color: Colors.pink,
//             child: const Text(
//               'Container 2',
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//           ),
//           Container(
//             width: 300,
//             color: Colors.green,
//             child: const Text(
//               'Container 3',
//               style: TextStyle(color: Colors.white, fontSize: 40),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



/* Columns - 2 */
// import 'package:flutter/material.dart';
// import 'package:t22mod1/home.dart';

// void main() {
//   runApp(const MaterialApp(home: Home()));
// }



/* Rows - 1 */
// import 'package:flutter/material.dart';
// import 'package:test/home.dart';

// void main() {
//   runApp(const MaterialApp(home: Sandbox()));
// }

// class Sandbox extends StatelessWidget {
//   const Sandbox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sandbox'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             height: 100,
//             color: Colors.black87,
//             child: const Text(
//               'Container 1',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           Container(
//             height: 200,
//             color: Colors.pink,
//             child: const Text(
//               'Container 2',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           Container(
//             height: 300,
//             color: Colors.green,
//             child: const Text(
//               'Container 3',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       )
//     );
//   }
// }



/* Rows - 2 */
// import 'package:flutter/material.dart';
// import 'package:t22mod1/home.dart';

// void main() {
//   runApp(const MaterialApp(home: Home()));
// }



/* Images - 1*/
// import 'package:flutter/material.dart';
// import 'package:t22mod1/home.dart';

// void main() {
//   runApp(const MaterialApp(home: Home()));
// }



/* Images - 2 */
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: Sample()));
// }

// class Sample extends StatelessWidget {
//   const Sample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image Network Example"),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Image.network(
//           'https://ih1.redbubble.net/image.1187851051.8476/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
//         ),
//       ),
//     );
//   }
// }



/* Expanded Widgets */
import 'package:flutter/material.dart';
import 'package:t22mod1/home.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}



