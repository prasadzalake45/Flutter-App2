import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // this for fetching data locally in asset folder
import 'package:login_form/cart_details.dart';
import 'package:login_form/item_detailed_page.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http; //
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert'; // for json decoding

// class Item {
//   final String name;
//   final String image;
//   final String description;
//   final double price;

//   Item({required this.name, required this.image, required this.description, required this.price});

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       name: json['name'],
//       image: json['image'],
//       description: json['description'],
//       price: json['price'].toDouble(),
//     );
//   }
// }

class ItemListPage extends StatefulWidget {
  ItemListPage({super.key});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final box = Hive.box('userBox'); //acccess Hive box
  List<dynamic> _items = []; 

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  //Future<void> _loadItems()-> signifies the asynchronous function in dart and does not return any value upon completion

  // Future represent the value that will be available at some poinht in future

  Future<void> _loadItems() async {
    // 1) This code for parsing json data locally

    // final String response = await rootBundle.loadString(
    //   'assets/items.json',
    // ); // load the json as String
    // final data = json.decode(response); // decode this JSON text into object

    // 2) This code for fetching data from API
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {

        final jsonData=json.decode(response.body);
        setState(() {
          _items = jsonData['products'];
        });
      } else {
        throw Exception("failed to load data from API ji");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = box.get(
      'username',
      defaultValue: "Geust",
    ); // get stored username
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Automatical leading menu remover

        leading: IconButton(
          onPressed: () {
            print("Menu Button is clicked");
          },

          icon: Icon(Icons.menu),
        ),
        title: Text(
          "Welcome, $username!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,

        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),

            onPressed: () {
        //         Navigator.push(
        // context,
        // MaterialPageRoute(
        //   builder: (context) => CartScreen(),
        // ), // Navigate if valid
      // );
            },
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      body:
          _items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio:
                      1, // Aspect ratio of each item (square shape)
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];   // all data in item 
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        // Navigate to detail screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetailPage(item: item),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child:CachedNetworkImage(
  imageUrl: item["images"][0],  // Use first image from list
  // placeholder: (context, url) => CircularProgressIndicator(),  // Show loader while loading
  errorWidget: (context, url, error) => Icon(Icons.error),  // Show error icon if fails
  fit: BoxFit.cover,
  height: 80,
  width: double.infinity, // takes full width of its parent container
)
                          ),
                          SizedBox(height: 8), // Space between image and name
                          Text(
                            item['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center, // Center align text
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
