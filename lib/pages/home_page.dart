import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              const Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.orange,
                  child: Text(
                    '3',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello,\nHi Staff',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Sunday, 12 June',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Product',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Stok',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const StockCard(
              title: 'Low Stock Products',
              subtitle: 'Red Gadget',
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            const Text(
              'Income',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            IncomeCard(
              amount: 'Rp. 45.000',
              color: Colors.brown[400]!,
            ),
          ],
        ),
      ),
    );
  }
}

class StockCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const StockCard({super.key, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}

class IncomeCard extends StatelessWidget {
  final String amount;
  final Color color;

  const IncomeCard({super.key, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Income Today',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
