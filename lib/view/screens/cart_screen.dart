import 'package:easy_mart/view/screens/dash_board_screen.dart';
import 'package:easy_mart/viewmodels/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: context.watch<CartProvider>().cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: width * 0.16,
              backgroundColor: Colors.orange.shade50,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: width * 0.18,
                color: Colors.orange,
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: height * 0.01),

            Text(
              "Add items to start shopping",
              style: TextStyle(
                fontSize: width * 0.04,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: height * 0.03),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                  vertical: height * 0.015,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => DashBoardScreen()),
                );
              },
              child: Text(
                "Shop Now",
                style: TextStyle(
                  fontSize: width * 0.045,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),)
          : bottomButton(height, width),

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashBoardScreen()),
              );
            },
            child: CircleAvatar(
              radius: width * 0.04,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            if (cart.cartItems.isEmpty) {
              return const Center(child: Text("Cart Empty"));
            }

            return ListView.builder(
              padding: EdgeInsets.all(width * 0.04),
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];

                return cartItem(item, height, width);
              },
            );
          },
        ),
      ),
    );
  }

  Widget cartItem(item, double height, double width) {
    final cart = context.read<CartProvider>();

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [

          // IMAGE
          Container(
            height: height * 0.10,
            width: width * 0.18,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(item.image, fit: BoxFit.contain),
          ),

          SizedBox(width: width * 0.03),

          // NAME + PRICE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(height: height * 0.005),


                Text(
                  item.category,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                  ),
                ),

                SizedBox(height: height * 0.008),

                Text(
                  "\$${item.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // DELETE + QTY
          Column(
            children: [

              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => cart.removeItem(item.id),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.orange,
                    size: width * 0.07,
                  ),
                ),
              ),

              SizedBox(height: height * 0.01),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.006,
                ),
                decoration: BoxDecoration(
                  color:  Colors.grey.shade100,
                  border: Border.all(
                      color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => cart.decreaseQty(item.id),
                      child: Icon(Icons.remove, size: width * 0.05),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      item.qty.toString(),
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    GestureDetector(
                      onTap: () => cart.increaseQty(item.id),
                      child: Icon(Icons.add, size: width * 0.05),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomButton(double height, double width) {
    TextEditingController discountController = TextEditingController();
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Container(
          padding: EdgeInsets.all(width * 0.06),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: discountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    fontSize: width * 0.040,
                    fontWeight: FontWeight.w200,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Discount Code",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: GestureDetector(
                        onTap: () {

                          final value = double.tryParse(discountController.text);

                          if (value != null && value > 0) {

                            context.read<CartProvider>().applyDiscount(value);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Discount Applied")),
                            );

                          } else {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter valid discount")),
                            );

                          }
                        },
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.040,
                          ),
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.015,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.black38,
                    ),
                  ),
                  Text(
                    "\$${cart.subtotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${cart.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}