import 'package:flutter/material.dart';

class BookingSummary extends StatelessWidget {
  final Map<String, dynamic> bookingData;
  final Function(Map<String, dynamic>) onBook;

  const BookingSummary({
    super.key,
    required this.bookingData,
    required this.onBook,
  });

  String _getFullName(String? firstName, String? lastName) {
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 80),
              title: const Text(
                'BOOKING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: ClipPath(
                clipper: AppBarWaveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/img/bg-top.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Form Summary',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InfoSection(
                    title: 'BOOKING INFORMATION',
                    backgroundColor: const Color(0xFFF75270),
                    titleColor: Colors.white,
                    items: [
                      MapEntry('Arrival:', bookingData['arrival'] ?? ''),
                      MapEntry('Departure:', bookingData['departure'] ?? ''),
                    ],
                  ),

                  InfoSection(
                    title: 'NUMBER OF PARTICIPANTS',
                    backgroundColor: const Color(0xFFF75270),
                    titleColor: Colors.white,
                    items: [
                      MapEntry('Adults:', '${bookingData['adults'] ?? 0}'),
                      MapEntry('Kids:', '${bookingData['kids'] ?? 0}'),
                    ],
                  ),

                  InfoSection(
                    title: 'BOOKER INFORMATION',
                    backgroundColor: const Color(0xFFF75270),
                    titleColor: Colors.white,
                    items: [
                      MapEntry(
                        'Full Name:',
                        _getFullName(
                          (bookingData['bookerInfo'] as Map?)?['firstName'],
                          (bookingData['bookerInfo'] as Map?)?['lastName'],
                        ),
                      ),
                      MapEntry(
                        'Age:',
                        '${((bookingData['bookerInfo'] as Map?)?['age'] ?? '')}',
                      ),
                      MapEntry(
                        'Gender:',
                        (bookingData['bookerInfo'] as Map?)?['gender'] ?? '',
                      ),
                      MapEntry(
                        'Origin:',
                        (bookingData['bookerInfo'] as Map?)?['origin'] ?? '',
                      ),
                    ],
                  ),

                  ...((bookingData['participants'] as List?)
                              ?.cast<Map<String, dynamic>>())
                          ?.asMap()
                          .entries
                          .map((entry) {
                            final participant = entry.value;
                            return InfoSection(
                              title: 'PARTICIPANT ${entry.key + 1}',
                              titleSize: 16,
                              backgroundColor: const Color(0xFFF75270),
                              titleColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              items: [
                                MapEntry(
                                  'Full Name:',
                                  _getFullName(
                                    participant['firstName'],
                                    participant['lastName'],
                                  ),
                                ),
                                MapEntry('Age:', '${participant['age'] ?? ''}'),
                                MapEntry(
                                  'Gender:',
                                  participant['gender'] ?? '',
                                ),
                              ],
                            );
                          })
                          .toList() ??
                      [],

                  InfoSection(
                    title: 'CONTACT INFORMATION',
                    backgroundColor: const Color(0xFFF75270),
                    titleColor: Colors.white,
                    items: [
                      MapEntry(
                        'Full Name:',
                        _getFullName(
                          (bookingData['contactInfo'] as Map?)?['firstName'],
                          (bookingData['contactInfo'] as Map?)?['lastName'],
                        ),
                      ),
                      MapEntry(
                        'Complete Address:',
                        (bookingData['contactInfo'] as Map?)?['address'] ?? '',
                      ),
                      MapEntry(
                        'Mobile Number:',
                        (bookingData['contactInfo'] as Map?)?['mobile'] ?? '',
                      ),
                      MapEntry(
                        'E-mail Address:',
                        (bookingData['contactInfo'] as Map?)?['email'] ?? '',
                      ),
                    ],
                  ),

                  InfoSection(
                    title: 'PAYMENT',
                    backgroundColor: const Color(0xFFF75270),
                    titleColor: Colors.white,
                    items: [
                      MapEntry(
                        'Sender\'s Full Name:',
                        (bookingData['payment'] as Map?)?['senderName'] ?? '',
                      ),
                      MapEntry(
                        'Mode of Payment:',
                        (bookingData['payment'] as Map?)?['paymentMode'] ?? '',
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF7CAC9),
                          minimumSize: const Size(130, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Back',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC143C),
                          minimumSize: const Size(130, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          print('Submitting final booking data: $bookingData');
                          onBook(
                            bookingData,
                          ); // Add booking to list in main.dart

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('You successfully booked!'),
                              backgroundColor: Color(0xFFF75270),
                            ),
                          );

                          // Pop all routes back to home screen after short delay
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          });
                        },
                        child: const Text(
                          'Finish',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 3
                              ? const Color(0xFFDC143C)
                              : const Color(0xFFF7CAC9),
                        ),
                      ),
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

class InfoSection extends StatelessWidget {
  final String title;
  final List<MapEntry<String, String>> items;
  final double titleSize;
  final Color titleColor;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const InfoSection({
    super.key,
    required this.title,
    required this.items,
    this.titleSize = 18,
    this.titleColor = const Color(0xFF1E4D92),
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (backgroundColor != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            )
          else
            Text(
              title,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    child: Text(
                      item.key,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
