import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../widget/adv.dart';
import 'menu.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  late Future<List> _futureRestaurants;

  // تعريف المتغيرات للألوان
  final Color primaryColor = Colors.blue;
  final Color secondaryColor = Colors.orange;
  final Color backgroundColor = Colors.white;
  final Color cardColor = Colors.orange[100]!;
  final Color textColor = Colors.black;
  final Color dividerColor = Colors.grey;
  final Color openColor = Colors.green;
  final Color closedColor = Colors.red;
  final Color hintColor = Colors.grey[600]!;

  Future<List> getItems() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:5000/popularItems"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _futureRestaurants = getRestaurant();
  }

  Future<List> getRestaurant() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:5000/restaurants"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Advertisements(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "ابحث عن مطعم...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  // تنفيذ عملية البحث
                },
              ),
            ),
            Row(
              children: [
                Expanded(child: Divider(thickness: 2, color: dividerColor)),
                Text(
                  " \t\tمطاعم مميزة \t",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                ),
                Expanded(child: Divider(thickness: 2, color: dividerColor)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List>(
                future: _futureRestaurants,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List restaurants = snapshot.data!;
                    return SizedBox(
                      height: screenHeight * 0.29,
                      child: ListView.builder(
                        itemCount: restaurants.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var restaurant = restaurants[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () => Get.to(() => Menu(id: restaurant["RestaurantID"], title: restaurant["Name"])),
                              child: Card(
                                color: cardColor,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  width: screenWidth * 0.4,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          "assets/images/download.jpeg",
                                          width: screenWidth * 0.4,
                                          height: screenHeight * 0.16,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        restaurant["Name"],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        restaurant["Address"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: hintColor,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        restaurant["isOpen"] == 1 ? "Open" : "Closed",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: restaurant["isOpen"] == 1 ? openColor : closedColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(child: Divider(thickness: 2, color: dividerColor)),
                Text(
                  " \t\t وجبات شائعة \t",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                ),
                Expanded(child: Divider(thickness: 2, color: dividerColor)),
              ],
            ),
            FutureBuilder(
              future: getItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return HorizontalItemList(items: snapshot.data != null ? snapshot.data! : [], type: 3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
