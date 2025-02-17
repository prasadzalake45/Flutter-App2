import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:login_form/item_detailed_page.dart';


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
  const ItemListPage({super.key});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final String response = await rootBundle.loadString('assets/items.json'); // load the json as String
    final data= json.decode(response); // decode this JSON text into object 
  
    setState(() {
      _items = data;
      print(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,  //Automatical leading menu remover

        title: const Text("Items List",
        style: TextStyle(color: Colors.white),
        
        
        ),
        backgroundColor: Colors.blue,
      ),
      body: _items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,

                
                // When I click on Image or Card


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
                
                  





                  child: ListTile(
                    leading: Image.asset(
                      item['image'], // images 
                      width: 60,
                      height: 60, 
                      fit: BoxFit.cover,
                    ),

                    

                    

                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['description']),
                    trailing: Text(item['price'].toStringAsFixed(2),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                );
              },
            ),
    );
  }
}
