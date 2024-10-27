import 'package:flutter/material.dart';
import '../data/item_data.dart';
import '../models/item_model.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  Item? _selectedItem;
  int _selectedQuantity = 1;
  String _selectedPaymentOption = 'Cash';
  List<Map<Item, int>> cart = []; // List barang dan jumlahnya

  void _updatePaymentOption(String option) {
    setState(() {
      _selectedPaymentOption = option;
    });
  }

  void _addToCart() {
    if (_selectedItem != null) {
      setState(() {
        cart.add({_selectedItem!: _selectedQuantity});
        _selectedItem = null; // Reset selection after adding
        _selectedQuantity = 1;
      });
    }
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (var entry in cart) {
      entry.forEach((item, quantity) {
        total += item.price * quantity;
      });
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Transaction',
          style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Item:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<Item>(
              isExpanded: true,
              value: _selectedItem,
              hint: const Text('Choose an item'),
              items: items.map((Item item) {
                return DropdownMenuItem<Item>(
                  value: item,
                  child: Text('${item.name} - Rp. ${item.price} (Stock: ${item.stock})'),
                );
              }).toList(),
              onChanged: (Item? newValue) {
                setState(() {
                  _selectedItem = newValue;
                  _selectedQuantity = 1; // Reset quantity
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Quantity:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_selectedItem != null) ...[
              Row(
                children: [
                  IconButton(
                    onPressed: _selectedQuantity > 1
                        ? () {
                      setState(() {
                        _selectedQuantity--;
                      });
                    }
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(_selectedQuantity.toString(), style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: _selectedQuantity < _selectedItem!.stock
                        ? () {
                      setState(() {
                        _selectedQuantity++;
                      });
                    }
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addToCart,
                child: const Text('Add to Cart'),
              ),
            ] else
              const Text('Please select an item first'),
            const SizedBox(height: 16),
            const Text('Cart:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final entry = cart[index];
                  final item = entry.keys.first;
                  final quantity = entry.values.first;

                  return Card(
                    child: ListTile(
                      title: Text('${item.name} x $quantity'),
                      trailing: Text('Rp. ${item.price * quantity}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  'Rp. ${_calculateTotalPrice()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                _buildPaymentOption('Cash'),
                _buildPaymentOption('Credit Card'),
                _buildPaymentOption('Digital Wallet'),
              ],
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: cart.isNotEmpty
                  ? () {
                print(
                    'Payment: $_selectedPaymentOption, Total: Rp. ${_calculateTotalPrice()}');
              }
                  : null,
              child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.brown,),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String option) {
    return ElevatedButton(
      onPressed: () => _updatePaymentOption(option),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedPaymentOption == option ? Colors.brown : Colors.grey,
      ),
      child: Text(option, style: const TextStyle(color: Colors.white)),
    );
  }
}
