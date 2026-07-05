class Fruit {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final String origin;
  final double rating;
  final int stock;

  Fruit({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.origin,
    required this.rating,
    required this.stock,
  });

  // Sample data
  static List<Fruit> getFruits() {
    return [
      Fruit(
        id: '1',
        name: 'Apel Fuji',
        price: 25000,
        image: '🍎',
        description: 'Apel Fuji segar dari Jepang, manis dan renyah.',
        origin: 'Jepang',
        rating: 4.8,
        stock: 50,
      ),
      Fruit(
        id: '2',
        name: 'Pisang Cavendish',
        price: 15000,
        image: '🍌',
        description: 'Pisang Cavendish premium, kaya akan kalium.',
        origin: 'Ekuador',
        rating: 4.5,
        stock: 100,
      ),
      Fruit(
        id: '3',
        name: 'Jeruk Valencia',
        price: 20000,
        image: '🍊',
        description: 'Jeruk Valencia segar, kaya vitamin C.',
        origin: 'Spanyol',
        rating: 4.7,
        stock: 75,
      ),
      Fruit(
        id: '4',
        name: 'Anggur Merah',
        price: 35000,
        image: '🍇',
        description: 'Anggur merah manis dari California.',
        origin: 'California',
        rating: 4.9,
        stock: 30,
      ),
      Fruit(
        id: '5',
        name: 'Strawberry',
        price: 40000,
        image: '🍓',
        description: 'Strawberry organik yang manis dan segar.',
        origin: 'Bogor',
        rating: 4.6,
        stock: 40,
      ),
      Fruit(
        id: '6',
        name: 'Semangka',
        price: 30000,
        image: '🍉',
        description: 'Semangka manis dan segar, cocok untuk cuaca panas.',
        origin: 'Lampung',
        rating: 4.4,
        stock: 20,
      ),
    ];
  }
}