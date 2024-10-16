class Item {
  final String name;
  final String description;
  final String? imageUrl;

  Item({required this.name, required this.description, this.imageUrl});

  // dumpy data
  static List<Item> getDummyItems() {
    return [
      Item(
        name: 'Laptop',
        description: 'Dell XPS 13, Core i7, 16GB RAM',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Item(
        name: 'Smartphone',
        description: 'iPhone 14 Pro, 256GB Storage',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Item(
        name: 'Headphones',
        description: 'Sony WH-1000XM5 Noise Canceling',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];
  }
}
