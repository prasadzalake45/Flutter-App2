import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:login_form/item_detailed_page.dart';
import 'package:hive/hive.dart';

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
    final box=Hive.box('userBox'); //acccess Hive box
  List _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  //Future<void> _loadItems()-> signifies the asynchronous function in dart and does not return any value upon completion

  // Future represent the value that will be available at some poinht in future

  Future<void> _loadItems() async {
    //

    final String response = await rootBundle.loadString(
      'assets/items.json',
    ); // load the json as String
    final data = json.decode(response); // decode this JSON text into object

    setState(() {
      _items = data;
      print(_items);
    });
  }

  @override
  Widget build(BuildContext context) {

    String username=box.get('username',defaultValue: "Geust"); // get stored username
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Automatical leading menu remover

        leading: IconButton(
          onPressed: () {
            print("Menu Button is clicked");
          },

          icon: Icon(Icons.menu),
        ),
        title:  Text("Welcome, $username!", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: _items.isEmpty
    ? const Center(child: CircularProgressIndicator())
    : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          childAspectRatio: 1, // Aspect ratio of each item (square shape)
          crossAxisSpacing: 10, // Spacing between columns
          mainAxisSpacing: 10, // Spacing between rows
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
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
                    child: Image.asset(
                      item["image"],
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8), // Space between image and name
                  Text(
                    item['name'],
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
