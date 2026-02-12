import 'package:easy_mart/modals/cart_model.dart';
import 'package:easy_mart/viewmodels/cart_provider.dart';
import 'package:easy_mart/viewmodels/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedColorIndex = 0;

  final List<Color> colors = [
    Colors.black54,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.grey,
  ];

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().resetQuantity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Icon(CupertinoIcons.back)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Icon(Icons.share_outlined)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Icon(CupertinoIcons.heart)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(20),
              child: Image.network(
                widget.product.image ?? "",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${widget.product.price ?? ""}",
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Seller : Syed Noman",
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rate,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "(320 Review)",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Color",
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(colors.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColorIndex == index
                                    ? colors[index]
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                      );
                    }),
                  ),
                  const SizedBox(height: 10),


                  // ================= TABS =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tabButton("Description", 0),
                      tabButton("Specification", 1),
                      tabButton("Reviews", 2),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (selectedTab == 0)
                    Text(
                      widget.product.description ?? "",
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    )

                  else if (selectedTab == 1)
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          specRow(Icons.category, "Category", widget.product.category),

                          const Divider(height: 25),

                          specRow(Icons.attach_money, "Price",
                              "\$${widget.product.price}"),

                          const Divider(height: 25),

                          specRow(Icons.confirmation_number,
                              "Product ID", "${widget.product.id}"),
                        ],
                      ),
                    )

                  else
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Rating Row
                          Row(
                            children: [
                              Text(
                                "${widget.product.rating.rate}",
                                style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),

                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index <
                                        widget.product.rating.rate
                                            .round()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "${widget.product.rating.count} Reviews",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Consumer<ProductProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade700),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  value.decrementQuantity();
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "${value.quantity}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  value.incrementQuantity();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                final cart = context.read<CartProvider>();

                                bool added = cart.addToCart(
                                  CartModel(
                                    id: widget.product.id,
                                    name: widget.product.title,
                                    price: widget.product.price.toDouble(),
                                    image: widget.product.image,
                                    category: widget.product.category,
                                    qty: context.read<ProductProvider>().quantity,
                                  ),
                                );

                                if (added) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Added to cart")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Already added to cart")),
                                  );
                                }
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );


  }



  /// TAB BUTTON
  Widget tabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTab == index
              ? Colors.orange
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedTab == index
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget specRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

}