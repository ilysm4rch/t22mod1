/* Rows - 2 */
// import 'package:flutter/material.dart';

// class SysDev extends StatelessWidget {
//   const SysDev({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//         Row(
//           children: [
//             Text('System Development: '),
//             Text('25 Students'),
//             SizedBox(width: 50)
//           ],
//         ),
//         Row(
//           children: [
//             Text('Networking: '),
//             Text('32 Students'),
//             SizedBox(width: 50)
//           ],
//         ),
//       ],
//     );
//   }
// }



/* Images - 1 */
// import 'package:flutter/material.dart';

// class SysDev extends StatelessWidget {
//   const SysDev({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Text('System Development: '),
//             const Text('25 Students'),
//             Image.asset('assets/img/sysdev.jpg',
//               width: 25,
//               color: Colors.blueAccent,
//               colorBlendMode: BlendMode.multiply,
//             ),
//             SizedBox(width: 50)
//           ],
//         ),
//         Row(
//           children: [
//             const Text('Networking: '),
//             const Text('32 Students'),
//             Image.asset('assets/img/net.jpg',
//               width: 25,
//               color: Colors.blueAccent,
//               colorBlendMode: BlendMode.multiply,
//             ),
//             SizedBox(width: 50)
//           ],
//         ),
//       ],
//     );
//   }
// }



/* Expanded Widgets */
import 'package:flutter/material.dart';

class SysDev extends StatelessWidget {
  const SysDev({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/img/sysdev.jpg',
              width: 25,
              color: Colors.lightBlue,
              colorBlendMode: BlendMode.multiply,
            ),
            const Text('  System Development: '),
            const Text('25 Students'),
            Expanded(child: SizedBox()),
            const Text('+'),
          ],
        ),
        Row(
          children: [
            Image.asset('assets/img/net.jpg',
              width: 25,
              color: Colors.lightBlue,
              colorBlendMode: BlendMode.multiply,
            ),
            const Text('  Networking: '),
            const Text('32 Students'),
            Expanded(child: SizedBox()),
            const Text('+'),
          ],
        ),
      ],
    );
  }
}


