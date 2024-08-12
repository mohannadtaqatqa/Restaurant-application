import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/colors.dart';
import '../../viem_model/menu_vm.dart';
import '../widget/divider.dart';
import '../widget/horizaItemList.dart';

class Menu extends StatefulWidget {
  const Menu({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var viewModel = Get.put(MenuViewModel());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: titleStyle,
        ),
        backgroundColor: appBarColor,
      ),
      body: FutureBuilder(
        future: viewModel.getRestaurant(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error loading data"));
          }

          List restaurant = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.35,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/download.jpeg",
                        fit: BoxFit.cover,
                        height: screenHeight * 0.31,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Card(
                          color: cardColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/download.jpeg"),
                                  radius: 40,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant[0]['Name'] ?? 'No name',
                                      style: cardTitleStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      restaurant[0]['Address'] ?? 'No address',
                                      style: cardSubtitleStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      restaurant[0]['PhoneNumber'] ??
                                          'No phone number',
                                      style: cardSubtitleStyle,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: restaurant[0]['isOpen'] == 1
                                            ? openColor
                                            : closedColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        restaurant[0]['isOpen'] == 1
                                            ? "مفتوح"
                                            : "مغلق",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      restaurant[0]['Rating']?.toString() ??
                                          'No rating',
                                      style: cardSubtitleStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    const Icon(Icons.motorcycle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: viewModel.getItems(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text("Error loading data"));
                    }

                    List items = snapshot.data!;
                    return Column(
                      children: [
                        DividerSection(
                            title: "الوجبات",
                            sectionTitleStyle: sectionTitleStyle),
                        HorizontalItemList(items: items, type: 0),
                        DividerSection(
                            title: "السلطات",
                            sectionTitleStyle: sectionTitleStyle),
                        HorizontalItemList(items: items, type: 1),
                        DividerSection(
                            title: "المشروبات",
                            sectionTitleStyle: sectionTitleStyle),
                        HorizontalItemList(items: items, type: 2),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

