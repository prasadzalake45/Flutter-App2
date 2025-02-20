import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login_form/cart_model.dart';
import 'provider.dart';
import 'package:provider/provider.dart'; // Add provider package


class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item; // Mapping of items

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item["title"] ?? "Item Details",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: item["images"][0], // Use first image from list
                  // placeholder: (context, url) => CircularProgressIndicator(),  // Show loader while loading
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.error), // Show error icon if fails
                  fit: BoxFit.cover,
                  height: 250,

                  // width: double.infinity, // takes full width of its parent container
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item["title"] ?? "No name available",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              item["description"] ?? "No description available",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              (item["price"] is num)
                  ? "\₹${(item["price"] as num).toStringAsFixed(2)}"
                  : "Price not available",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Rating:${(item["rating"])}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Text(
              "Stocks:${(item["stock"])}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 80),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //create new cardItem and add to the cart

                  final newItem = CartItem(
                    id: item["id"].toString(),
                    title: item["title"] as String? ?? 'Unknown Title',
                    description: item['description'] as String? ?? 'No Description',
                    quantity: 1, //  default quantity to 1.
                    imageurl: item["images"][0]
                  );

                    print(newItem);

                  Provider.of<CartProvider>(
                    context,
                    listen:false
                    ).addTocart(newItem);

               
                  ScaffoldMessenger.of(context).showSnackBar
                  (SnackBar(content: Text('${item["title"]} added to cart!')));
                  
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
