import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> foodItems = [
      {
        "icon": Icons.lunch_dining,
        "name": "Cheese Burger",
        "price": "₹149"
      },
      {
        "icon": Icons.local_pizza,
        "name": "Veg Pizza",
        "price": "₹199"
      },
      {
        "icon": Icons.ramen_dining,
        "name": "Pasta",
        "price": "₹179"
      },
      {
        "icon": Icons.breakfast_dining,
        "name": "Sandwich",
        "price": "₹99"
      },
      {
        "icon": Icons.local_drink,
        "name": "Cold Drink",
        "price": "₹49"
      },
      {
        "icon": Icons.icecream,
        "name": "Ice Cream",
        "price": "₹69"
      },
      {
        "icon": Icons.cake,
        "name": "Chocolate Cake",
        "price": "₹149"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView Example"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  foodItems[index]["icon"],
                  size: 45,
                  color: Colors.orange,
                ),

                title: Text(
                  foodItems[index]["name"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  foodItems[index]["price"],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),

                trailing: const Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                  size: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}