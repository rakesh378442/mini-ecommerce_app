
class CartModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;
  int qty;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.qty = 1,
  });
}
