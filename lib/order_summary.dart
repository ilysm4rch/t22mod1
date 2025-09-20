import 'package:flutter/material.dart';

class OrderSummary extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems; // ✅ Accept cart items
  final VoidCallback onCartUpdated; // ✅ Callback to notify Home

  const OrderSummary({
    super.key,
    required this.cartItems,
    required this.onCartUpdated,
  });

  @override
  State<OrderSummary> createState() => OrderSummaryState();
}

class OrderSummaryState extends State<OrderSummary> {
  // ✅ Calculate total price
  int getTotal() {
    int total = 0;
    for (var item in widget.cartItems) {
      total += (item["price"] as int) * (item["quantity"] as int);
    }
    return total;
  }

  void updateAndNotify() {
    setState(() {});
    widget.onCartUpdated(); // ✅ tell Home to refresh cartCount
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedebdd),

      // Header Bar
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFB53324),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // ✅ Cart Items List
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty 🛒",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
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
                            item["item"],
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
                              // ➖ Decrease Quantity
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
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
                              // ➕ Increase Quantity
                              IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Colors.green),
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

          // ✅ Total Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
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
