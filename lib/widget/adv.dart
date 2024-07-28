import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Advertisements extends StatefulWidget {
  const Advertisements({super.key});

  @override
  State<Advertisements> createState() => _AdvertisementsState();
}

class _AdvertisementsState extends State<Advertisements> {
  List<ADV> adv = [
    ADV(path: 'assets/images/download.jpeg'),
    ADV(path: 'assets/images/pizza-01.png'),
    ADV(path: 'assets/images/pizza-02.png'),
  ];
  int activindex = 0;

  Widget buildindecator() => AnimatedSmoothIndicator(
        activeIndex: activindex,
        count: adv.length,
        effect: const WormEffect(),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          CarouselSlider.builder(
              options: CarouselOptions(
                  height: 250, // تناسق مع الصور
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9, // تناسق مع نسبة العرض إلى الارتفاع
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) =>
                      setState(() => activindex = index),
                  autoPlay: true,
                  reverse: false),
              itemCount: adv.length,
              itemBuilder: (context, i, realindex) {
                return addcard(adv[i]);
              }),
          const SizedBox(
            height: 15,
          ),
          buildindecator(),
        ],
      ),
    );
  }
}

class ADV {
  late String path;

  ADV({required this.path});
}

Widget addcard(ADV adv) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          adv.path,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
