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

      // ✅ Header Bar
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
      ),

      body: Column(
        children: [
          // ✅ Cart Items
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
                          leading: Image.asset(
                            item["image"],
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            // ✅ Show size beside item name
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
                              // ➖ Decrease
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
                              ),
                              Text(
                                "${item["quantity"]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              // ➕ Increase
                              IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Color(0xFFB53324)),
                                onPressed: () {
                                  item["quantity"]++;
                                  updateAndNotify();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // ✅ Bottom total
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
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
