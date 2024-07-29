import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  const Menu({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final Color primaryColor = Colors.blue;
  final Color secondaryColor = Colors.orange;
  final Color backgroundColor = Colors.white;
  final Color appBarColor = Colors.orange;
  final Color cardColor = Colors.orangeAccent;
  final Color textColor = Colors.black;
  final Color hintColor = Colors.grey[600]!;
  final Color openColor = Colors.green;
  final Color closedColor = Colors.red;

  final TextStyle titleStyle = const TextStyle(
    color: Color.fromARGB(255, 254, 254, 254),
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  final TextStyle sectionTitleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.orange,
  );

  final TextStyle cardTitleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  final TextStyle cardSubtitleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  Future<List> getRestaurant() async {
    final response = await http
        .get(Uri.parse("http://10.0.2.2:5000/restaurants/${widget.id}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  Future<List> getItems() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:5000/items/${widget.id}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
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
        future: getRestaurant(),
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
                Container(
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
                                      restaurant[0]['Rating'] ?? 'No rating',
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
                  future: getItems(),
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

class DividerSection extends StatelessWidget {
  final String title;
  final TextStyle sectionTitleStyle;

  const DividerSection(
      {super.key, required this.title, required this.sectionTitleStyle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider(thickness: 2)),
          Text(
            " $title ",
            style: sectionTitleStyle,
          ),
          const Expanded(child: Divider(thickness: 2)),
        ],
      ),
    );
  }
}

class HorizontalItemList extends StatelessWidget {
  final List items;
  final int type;

  const HorizontalItemList(
      {super.key, required this.items, required this.type});

  @override
  Widget build(BuildContext context) {
    // Check if the items list is empty
    if (items.isEmpty) {
      return Container(
        height: 30,
        child: Center(
          child: Text(
            "لا يوجد بيانات",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }
    // If items are present, display them
    return Container(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          Uint8List? imageBytes;

          // تحقق من أن `img` موجودة وليس null
          if (item["img"]['data'] != null && item["img"]['data'].isNotEmpty) {
            // تحويل `Buffer` إلى `Uint8List`
            try {
              List<int> imageBuffer = List<int>.from(
                  item["img"]['data']); // تحويل List<dynamic> إلى List<int>
              imageBytes = Uint8List.fromList(
                  imageBuffer); // تحويل List<int> إلى Uint8List
            } catch (e) {
              print("Error converting image buffer: $e");
              imageBytes = null; // في حال حدوث خطأ في التحويل
            }
          }

          if (item['type'] == type) {
            return InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {return
                      AlertDialog(
                        title:Text("هل تريد الاضافة للسلة؟"),
                        content: Column(
                          children: [
                            Text(""),
                            SizedBox(height: 10),

                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text("اضافة للسلة"),
                            onPressed: () {},
                          ),
                          TextButton(
                            child: Text("الغاء"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (imageBytes != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            imageBytes,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                        ),
                      const SizedBox(height: 5),
                      Text(
                        type == 3
                            ? item['Name']
                            : item['ItemName'] ?? 'No item name',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${item['Price']} شيكل",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
