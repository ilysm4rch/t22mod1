import 'package:flutter/material.dart';

class OrderSummary extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final VoidCallback onCartUpdated;

  const OrderSummary({
    super.key,
    required this.cartItems,
    required this.onCartUpdated,
  });

  @override
  State<OrderSummary> createState() => OrderSummaryState();
}

class OrderSummaryState extends State<OrderSummary> {
  int getTotal() {
    int total = 0;
    for (var item in widget.cartItems) {
      total += (item["price"] as int) * (item["quantity"] as int);
    }
    return total;
  }

  void updateAndNotify() {
    setState(() {});
    widget.onCartUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),

      // header
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB53324),
          ),
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        centerTitle: true,
        elevation: 0,
        // Change back arrow color to match your theme
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB53324)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Column(
        children: [
          // added items
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB53324),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    item["image"],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                width: 4,
                                height: 30, 
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD98236),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            "${item["item"]} (${item["size"] ?? 'No size'})",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "₱${item["price"]} x ${item["quantity"]}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Color(0xFFB53324)),
                                onPressed: () {
                                  if (item["quantity"] > 1) {
                                    item["quantity"]--;
                                  } else {
                                    widget.cartItems.removeAt(index);
                                  }
                                  updateAndNotify();
                                },
                                iconSize: 23,
                              ),
                              Text(
                                "${item["quantity"]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Color(0xFFB53324)),
                                onPressed: () {
                                  item["quantity"]++;
                                  updateAndNotify();
                                },
                                iconSize: 23,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // total
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF0f0f0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₱${getTotal()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB53324),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}