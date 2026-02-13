import 'dart:async';
import 'package:easy_mart/view/screens/product_details_screen.dart';
import 'package:easy_mart/viewmodels/category_provider.dart';
import 'package:easy_mart/viewmodels/product_provider.dart';
import 'package:easy_mart/viewmodels/slider_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
    Future.microtask(() {
      context.read<SliderProvider>().startAutoSlide();
    },);

  }
  @override
  void dispose() {
    context.read<SliderProvider>().disposeTimer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    final Size size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
          provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.all(w * 0.04),
                children: [
                  // Top icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      circleIcon(Icons.grid_view_rounded, w),
                      circleIcon(CupertinoIcons.bell, w),
                    ],
                  ),

                  SizedBox(height: h * 0.025),
                  TextField(
                    onChanged: (value) {
                      context.read<ProductProvider>().searchProducts(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(CupertinoIcons.search),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 2,
                            height: h * 0.016,
                            color: Colors.black54,
                          ),
                          SizedBox(width: w * 0.02),
                          const Icon(Icons.filter_list_rounded),
                        ],
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.025),
                  Consumer<SliderProvider>(
                    builder: (context, bannerProvider, child) {
                      return SizedBox(
                        height: h * 0.22,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(w * 0.05),
                          child: Stack(
                            children: [

                              // 🔹 BACKGROUND IMAGE
                              Positioned.fill(
                                child: Image.asset(
                                  "assets/images/backgroun.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // 🔹 PAGE VIEW CONTENT
                              PageView.builder(
                                controller: bannerProvider.pageController,
                                itemCount: bannerProvider.images.length,
                                onPageChanged: bannerProvider.onPageChanged,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Row(
                                      children: [


                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Super Sale\nDiscount",
                                                style: TextStyle(
                                                  fontSize: w * 0.058,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    "Up to",
                                                    style: TextStyle(
                                                      fontSize: w * 0.037,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    " 50%",
                                                    style: TextStyle(
                                                      fontSize: w * 0.08,
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: h * 0.01),

                                              SizedBox(
                                                height: h * 0.042,
                                                width: w * 0.27,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.orange,
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Shop Now",
                                                    style: TextStyle(
                                                      fontSize: w * 0.03,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 🔹 IMAGE SECTION
                                        Expanded(
                                          flex: 6,
                                          child: SizedBox(
                                            height: h * 0.20,
                                            child: Image.asset(
                                              bannerProvider.images[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              // 🔹 INDICATOR
                              Positioned(
                                bottom: h * 0.01,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    bannerProvider.images.length,
                                        (index) {
                                      bool isActive =
                                          bannerProvider.currentPage == index;

                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin:
                                        EdgeInsets.symmetric(horizontal: w * 0.01),
                                        width: isActive ? w * 0.04 : w * 0.02,
                                        height: w * 0.02,
                                        decoration: BoxDecoration(
                                          color:
                                          isActive ? Colors.black : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(w * 0.02),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: h * 0.025),

                  categoryList(w, h),

                  SizedBox(height: h * 0.025),

                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Special For You",
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("See all", style: TextStyle(fontSize: w * 0.035)),
                    ],
                  ),
                  SizedBox(height: h * 0.02),
                  Consumer<ProductProvider>(
                    builder: (context, provider, child) {

                      if (provider.isLoading || provider.isSearching) {
                        return SizedBox(
                          height: h * 0.4,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (provider.productList.isEmpty) {
                        return SizedBox(
                          height: h * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 60, color: Colors.grey),
                              SizedBox(height: h * 0.01),
                              Text(
                                "No Product Found",
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }


                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.productList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: h * 0.24,
                          crossAxisSpacing: w * 0.03,
                          mainAxisSpacing: h * 0.02,
                        ),
                        itemBuilder: (context, index) {
                          final product = provider.productList[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            child: productCard(
                              product.image,
                              product.title,
                              product.price.toString(),
                              w,
                              h,
                            ),
                          );
                        },
                      );
                    },
                  )



                ],
              ),
      ),
    );
  }

  Widget productCard(
    String image,
    String title,
    String price,
    double w,
    double h,
  ) {
    return Stack(
      children: [
        Container(
          width: w * 0.42,
          height: h * 0.24,
          padding: EdgeInsets.fromLTRB(w * 0.03, h * 0.025, w * 0.03, h * 0.02),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(w * 0.045),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  image,
                  height: h * 0.11,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: h * 0.015),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: w * 0.032,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: h * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$$price",
                    style: TextStyle(
                      fontSize: w * 0.036,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      colorDot(Colors.black, w),
                      colorDot(const Color(0xFF9E9E9E), w),
                      colorDot(const Color(0xFFFF9800), w),
                      colorDot(const Color(0xFF03A9F4), w),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Favorite
        Positioned(
          top: h * 0.00,
          right: w * 0.024,
          child: Container(
            width: w * 0.06,
            height: w * 0.06,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(w * 0.03),
                bottomLeft: Radius.circular(w * 0.03),
              ),
            ),
            child: Icon(
              Icons.favorite_border,
              size: w * 0.035,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget colorDot(Color color, double w) {
    return Container(
      margin: EdgeInsets.only(right: w * 0.015),
      width: w * 0.025,
      height: w * 0.025,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget circleIcon(IconData icon, double w) {
    return CircleAvatar(
      radius: w * 0.05,
      backgroundColor: Colors.grey.shade200,
      child: Icon(icon, color: Colors.black, size: w * 0.055),
    );
  }

  Widget categoryList(double w, double h) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return SizedBox(
          height: h * 0.13,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];

              final bool isSelected = category.name == selectedCategory;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category.name;
                  });

                  context
                      .read<ProductProvider>()
                      .filterByCategory(category.name);
                },

                child: categoryItem(
                  getCategoryIcon(category.name),
                  category.name,
                  isSelected,
                  w,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget categoryItem(IconData icon, String text, bool selected, double w) {
    return Padding(
      padding: EdgeInsets.only(right: w * 0.04),
      child: Column(
        children: [
          Container(
            width: w * 0.16,
            height: w * 0.16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(
                color: selected ? Colors.orange : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(icon, size: w * 0.07, color: Colors.black87),
          ),
          SizedBox(height: w * 0.015),

          Text(
            capitalize(text),
            style: TextStyle(
              color: selected ? Colors.orange : Colors.black87,
              fontSize: w * 0.032,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "all":
        return Icons.grid_view_rounded;
      case "men's clothing":
      case "men":
        return Icons.man;
      case "women's clothing":
        return Icons.woman;
      case "jewelery":
      case "watch":
        return Icons.watch;
      case "electronics":
        return Icons.headphones;
      case "shoes":
        return Icons.directions_run;
      default:
        return Icons.category;
    }
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

