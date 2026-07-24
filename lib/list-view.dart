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
      home: FoodMenuScreen(),
    );
  }
}

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  final List<Map<String, dynamic>> foods = const [
    {
      "name": "Cheese Burger",
      "price": "₹149",
      "icon": Icons.lunch_dining,
      "color": Colors.orange,
    },
    {
      "name": "Veg Pizza",
      "price": "₹199",
      "icon": Icons.local_pizza,
      "color": Colors.deepOrange,
    },
    {
      "name": "Pasta",
      "price": "₹179",
      "icon": Icons.ramen_dining,
      "color": Colors.red,
    },
    {
      "name": "Sandwich",
      "price": "₹99",
      "icon": Icons.breakfast_dining,
      "color": Colors.amber,
    },
    {
      "name": "Cold Drink",
      "price": "₹49",
      "icon": Icons.local_drink,
      "color": Colors.brown,
    },
    {
      "name": "Ice Cream",
      "price": "₹69",
      "icon": Icons.icecream,
      "color": Colors.pink,
    },
    {
      "name": "Chocolate Cake",
      "price": "₹149",
      "icon": Icons.cake,
      "color": Colors.brown,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
        title: const Text("ListView Example"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemCount: foods.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),

                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor:
                  foods[index]["color"].withOpacity(0.15),
                  child: Icon(
                    foods[index]["icon"],
                    size: 34,
                    color: foods[index]["color"],
                  ),
                ),

                title: Text(
                  foods[index]["name"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  foods[index]["price"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                trailing: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.green,
                  size: 34,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}