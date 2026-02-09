class CartModel {
  final int id;
  final String name;
  final double price;
  final String image;
  int qty;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.qty = 1,
  });
}
