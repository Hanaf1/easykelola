import 'package:flutter/material.dart';
import '../data/item_data.dart'; // Import item data
import '../models/item_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Inventory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            // List of Products
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ProductCard(
                    item: item,
                    onEdit: () => _showEditDialog(context, item, index),
                    onDelete: () => _showDeleteDialog(context, index),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showAddDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Add New Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Add Product Dialog
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items.add(
                    Item(
                      name: nameController.text,
                      price: int.parse(priceController.text),
                      stock: int.parse(stockController.text),
                      imageUrl: imageUrlController.text,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show Edit Dialog
  void _showEditDialog(BuildContext context, Item item, int index) {
    final nameController = TextEditingController(text: item.name);
    final stockController = TextEditingController(text: item.stock.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items[index] = Item(
                    name: nameController.text,
                    price: item.price,
                    stock: int.parse(stockController.text),
                    imageUrl: item.imageUrl,
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Dialog
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Item item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Product Image
            CircleAvatar(
              backgroundImage: NetworkImage(item.imageUrl),
              radius: 25,
            ),
            const SizedBox(width: 16),
            // Product Name and Stock
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Stock: ${item.stock}'),
                ],
              ),
            ),
            // Edit and Delete Actions
            TextButton(
              onPressed: onEdit,
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: onDelete,
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
