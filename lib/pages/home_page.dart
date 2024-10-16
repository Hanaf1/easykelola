import 'package:flutter/material.dart';
import '../models/item.dart';
import 'add_item_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = Item.getDummyItems();

  void _navigateToAddItem() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage()),
    );

    if (newItem != null && newItem is Item) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  void _navigateToDetail(Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyKelola',style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddItem,
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(child: Text('No items. Add some!'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 4,
              child: ListTile(
                leading: Image.network(
                  item.imageUrl ?? 'https://via.placeholder.com/150',
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () => _navigateToDetail(item),
              ),
            ),
          );
        },
      ),
    );
  }
}
