import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SmartCafe(),
    );
  }
}

class SmartCafe extends StatefulWidget {
  const SmartCafe({super.key});

  @override
  State<SmartCafe> createState() => _SmartCafeState();
}

class _SmartCafeState extends State<SmartCafe> {
  List<String> categories = [
    "Burger",
    "Pizza",
    "Sandwich",
    "Cold Coffee",
    "French Fries"
  ];

  Map<String, Map<String, dynamic>> items = {
    "Burger": {
      "name": "Veg Burger",
      "price": 120,
      "icon": Icons.lunch_dining
    },
    "Pizza": {
      "name": "Cheese Pizza",
      "price": 199,
      "icon": Icons.local_pizza
    },
    "Sandwich": {
      "name": "Veg Sandwich",
      "price": 99,
      "icon": Icons.breakfast_dining
    },
    "Cold Coffee": {
      "name": "Cold Coffee",
      "price": 80,
      "icon": Icons.local_cafe
    },
    "French Fries": {
      "name": "French Fries",
      "price": 90,
      "icon": Icons.fastfood
    },
  };

  String selectedCategory = "Burger";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var item = items[selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back),
        title: const Text("Smart Café"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: "Cheese",
                  child: Text("Add Cheese")),
              const PopupMenuItem(
                  value: "Sauce",
                  child: Text("Extra Sauce")),
              const PopupMenuItem(
                  value: "Nutrition",
                  child: Text("View Nutrition")),
            ],
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {},
        child: const Icon(Icons.restaurant_menu),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [

            const Text(
              "Choose Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              items: categories.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Icon(item["icon"], size: 35),
                ),
                title: Text(
                  item["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("₹${item["price"]}"),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quantity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle),
                  color: Colors.deepPurple,
                  iconSize: 40,
                ),

                Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle),
                  color: Colors.deepPurple,
                  iconSize: 40,
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  content:
                  Text("Order Placed Successfully"),
                ));
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Place Order"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () {},
              child: const Text("Save for Later"),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                setState(() {
                  quantity = 1;
                });
              },
              child: const Text(
                "Clear Selection",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}