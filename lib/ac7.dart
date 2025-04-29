import 'package:flutter/material.dart';

void main() {
  runApp(const QuickBiteApp());
}

class QuickBiteApp extends StatefulWidget {
  const QuickBiteApp({super.key});

  @override
  State<QuickBiteApp> createState() => _QuickBiteAppState();
}

class _QuickBiteAppState extends State<QuickBiteApp> {
  final List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> food) {
    setState(() {
      cartItems.add(food);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickBite',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomeScreen(cartItems: cartItems, addToCart: addToCart),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) addToCart;

  const HomeScreen({
    super.key,
    required this.cartItems,
    required this.addToCart,
  });

  final List<Map<String, dynamic>> foodItems = const [
    {'name': 'Pizza', 'price': 12.99, 'image': 'pizza.jpg'},
    {'name': 'Burger', 'price': 8.99, 'image': 'burger.png'},
    {'name': 'Pasta', 'price': 10.99, 'image': 'pasta.jpeg'},
    {'name': 'Sushi', 'price': 15.99, 'image': 'biriyani.jpeg'},
    {'name': 'Sushi', 'price': 15.99, 'image': 'spagati.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          FoodDetailsScreen(food: item, addToCart: addToCart),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${item['price']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> food;
  final Function(Map<String, dynamic>) addToCart;

  const FoodDetailsScreen({
    super.key,
    required this.food,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food['name'])),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              food['image'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${food['price']}',
                  style: const TextStyle(fontSize: 22, color: Colors.orange),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    addToCart(food);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item added to cart!")),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body:
          cartItems.isEmpty
              ? const Center(
                child: Text(
                  "Your cart is empty!",
                  style: TextStyle(fontSize: 20),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              item['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item['name']),
                            subtitle: Text("\$${item['price']}"),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.orange[100]),
                    child: Column(
                      children: [
                        Text(
                          "Total: \$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Checkout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}