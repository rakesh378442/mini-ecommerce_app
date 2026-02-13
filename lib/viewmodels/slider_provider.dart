import 'dart:async';
import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {

  PageController pageController = PageController();

  int currentPage = 0;
  Timer? timer;

  List<String> images = [
    "assets/images/Shoes5.png",
    "assets/images/Shoes2.png",
    "assets/images/Shoes3.png",
    "assets/images/Shoes4.png",
    "assets/images/Shoes1.png",
  ];


  void startAutoSlide() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {

      if (!pageController.hasClients) return;

      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );

      notifyListeners();
    });
  }


  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }


  void disposeTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    disposeTimer();
    pageController.dispose();
    super.dispose();
  }
}
