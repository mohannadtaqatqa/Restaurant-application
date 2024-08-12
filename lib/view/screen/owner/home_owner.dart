import 'package:flutter/material.dart';
import 'package:foodapp/core/constant/colors.dart';
import 'package:foodapp/view/widget/adv.dart';
import 'package:get/get.dart';

import 'add_product.dart';
import 'order_page.dart';

class HomePageOwner extends StatelessWidget {
  const HomePageOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الصفحة الرئيسية',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      drawer: _buildDrawer(context),
      drawerScrimColor: const Color.fromARGB(149, 0, 0, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              // padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     "مرحبا بك يا محمد",
              //     style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              //   ),
              // ),
              const Advertisements(),
              _buildFeatureSection(context),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "المنتجات",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18),
                height: 220,
                width: 150,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/images/pizza-06.png"),
                    const Text(
                      "اسم المنتج",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const Text(
                      "100 شيكل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeatureCard(
              icon: Icons.add,
              label: "اضافة منتج",
              onPressed: () {
                Get.to(() => const AddProduct());
              },
            ),
            _buildFeatureCard(
              icon: Icons.handshake,
              label: "الطلبات",
              onPressed: () {
                Get.to(() => OwnerOrdersPage());
                // تنفيذ عملية عرض الطلبات
              },
            ),
            _buildFeatureCard(
              icon: Icons.receipt_long,
              label: "التقارير",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildDiscountSection() {
  //   // استبدال هذا الكود بمخططات حقيقية أو إحصائيات بناءً على بيانات التطبيق
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "إدارة العروض والخصومات",
  //           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(height: 10),
  //         Container(
  //           height: 150,
  //           color: Colors.grey[200], // Placeholder for discount management
  //           child: Center(
  //             child: Text(
  //               "واجهة إدارة العروض والخصومات هنا",
  //               style: const TextStyle(color: Colors.grey),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              'القائمة الجانبية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('الصفحة الرئيسية'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            onTap: () {
              // الانتقال إلى صفحة الملف الشخصي
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            onTap: () {
              // الانتقال إلى صفحة الإعدادات
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              // تنفيذ عملية تسجيل الخروج
            },
          ),
        ],
      ),
    );
  }
}

// Widget _buildStatisticsSection() {
//   // استبدال هذا الكود بمخططات حقيقية أو إحصائيات بناءً على بيانات التطبيق
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "إحصائيات الأداء",
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           height: 200,
//           color: Colors.grey[200], // Placeholder for a chart or statistics
//           child: Center(
//             child: Text(
//               "رسم بياني أو إحصائيات هنا",
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildDiscountSection() {
//   // استبدال هذا الكود بمخططات حقيقية أو إحصائيات بناءً على بيانات التطبيق
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "إدارة العروض والخصومات",
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           height: 150,
//           color: Colors.grey[200], // Placeholder for discount management
//           child: Center(
//             child: Text(
//               "واجهة إدارة العروض والخصومات هنا",
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget _buildFeatureCard({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Text(
            'القائمة الجانبية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('الصفحة الرئيسية'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('الملف الشخصي'),
          onTap: () {
            // الانتقال إلى صفحة الملف الشخصي
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('الإعدادات'),
          onTap: () {
            // الانتقال إلى صفحة الإعدادات
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('تسجيل الخروج'),
          onTap: () {
            // تنفيذ عملية تسجيل الخروج
          },
        ),
      ],
    ),
  );
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReportSection(
                title: "الأداء المالي",
                content: "إيرادات اليوم: \$500\nإيرادات الشهر: \$15000",
              ),
              const SizedBox(height: 20),
              _buildReportSection(
                title: "تقارير الطلبات",
                content: "الطلبات المكتملة: 100\nالطلبات الملغاة: 5",
              ),
              const SizedBox(height: 20),
              _buildReportSection(
                title: "تقارير العملاء",
                content: "العملاء الجدد: 20\nتقييمات العملاء: 4.5/5",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
