import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/tax_hiring_module/src/constants/image_strings.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/all_hirings/allHirings.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/personal_chat/screens/chat_home_screen.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/add_product.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/myorders/myordersHome.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/products_list.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/products_list_by_category.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/profile/settings_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class TaxHome extends StatefulWidget {
  const TaxHome({super.key});

  @override
  State<TaxHome> createState() => _TaxHomeState();
}

class _TaxHomeState extends State<TaxHome> {
  String userName = "";
  String email = "";
  bool isAdmin = false;

  final String _status = "";
  List<GCircle> loaders = <GCircle>[];

  @override
  void initState() {
    super.initState();
    Get.put(AuthenticationRepository());

    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userName = value.data()!["name"];
        email = value.data()!["email"];

        print(value.data()!['firstName']);
        print(value.data()!['lastName']);

        print("$userName $email");

        if (value.data()!["level"] == "admin") {
          isAdmin = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController searchController = TextEditingController();

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.home,
          //     color: Colors.white,
          //   ),
          // ),
          centerTitle: true,
          title: const Text(
            "Travel Agency",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),

          actions: [
            IconButton(
              onPressed: () {
                // AuthenticationRepository.instance.logout();
                Get.to(() => const SettingsScreen());
              },
              //three dots from font awesome
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.transparent,
                ),
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  accountName: Text(
                    userName,
                    style: const TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(
                    email,
                    style: const TextStyle(color: Colors.black),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage(
                      tProfileImage,
                    ),
                  ),
                ),
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                leading: const Icon(
                  Icons.home,
                  color: Colors.orangeAccent,
                ),
                title: const Text(
                  'Home',
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              if (email == "gzutravelagency@gmail.com" || isAdmin)
                ListTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    leading: const Icon(
                      Icons.add,
                      color: Colors.orangeAccent,
                    ),
                    title: const Text('Add Vehicle'),
                    onTap: () {
                      Get.to(() => const addProductPage());
                    }),
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const addProductPage()));
              //   },
              // ),

              // ListTile(
              //   trailing: const Icon(
              //     Icons.arrow_forward_ios,
              //   ),
              //   leading: const Icon(
              //     Icons.shopping_basket,
              //     color: Colors.orangeAccent,
              //   ),
              //   title: const Text('Cart'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const CartHome()));
              //   },
              // ),

              ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  leading: const Icon(
                    Icons.fastfood,
                    color: Colors.orangeAccent,
                  ),
                  title: const Text('My Bookings'),
                  onTap: () {
                    Get.to(() => const MyOrders());
                  }),

              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const MyOrders()));
              //   },
              // ),
              if (email == "gzutravelagency@gmail.com" || isAdmin)
                ListTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    leading: const Icon(
                      Icons.add,
                      color: Colors.orangeAccent,
                    ),
                    title: const Text('All Hirings'),
                    onTap: () {
                      Get.to(() => const AllHirings());
                    }),

              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const AllHirings()));
              //   },
              // ),
              //customer support
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                leading: const Icon(
                  Icons.support_agent,
                  color: Colors.orangeAccent,
                ),
                title: const Text('Customer Support'),
                onTap: () {
                  Get.to(() => const ChatHomePage());

                  // Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ChatHomePage()));
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                leading: const Icon(
                  Icons.clear,
                  color: Colors.orangeAccent,
                ),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  _showConfirmationBottomSheet(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xfff5f7fa),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: size.height * .30,
                    width: size.width,
                  ),
                  GradientContainer(size),
                  Positioned(
                    top: size.height * .06,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Vehicle Hiring Service!",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            "High quality vehicle hiring service",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                child: Container(
                                  height: size.height * .15,
                                  width: size.width * .4,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        passengerVh,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        top: size.height * .12,
                                      ),
                                      child: const Text(
                                        'Very',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                // onTap: () => Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Rooms(),
                                //   ),
                                // ),
                                child: Container(
                                  height: size.height * .15,
                                  width: size.width * .4,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        lightTruck,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        top: size.height * .12,
                                      ),
                                      child: const Text(
                                        'Affordable',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DevicesGridDashboard(size: size),
                    //ScenesDashboard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //  Perform logout action
                        Navigator.pop(context);
                        // Close the bottom sheet

                        //logout
                        AuthenticationRepository.instance.logout();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              tPrimaryColor.withOpacity(0.9),
              primaryColor.withOpacity(0.9)
            ])),
      ),
    );
  }

  List<GCircle> _buildLoaders() {
    loaders.clear();
    for (int i = 0; i < 3; i++) {
      loaders.add(GCircle(Colors.black));
    }
    return loaders;
  }
}

class ScenesDashboard extends StatelessWidget {
  const ScenesDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const SettingsScreen(),
                  );
                },
                child: CardWidget(
                    icon: Icon(
                      Icons.settings,
                      color: secondaryColor,
                    ),
                    title: 'Settings'),
              ),
              GestureDetector(
                onTap: () {
                  _showConfirmationBottomSheet(
                      context); // Show the bottom sheet on tap
                },
                child: CardWidget(
                    icon: Icon(
                      Icons.local_fire_department_outlined,
                      color: secondaryColor,
                    ),
                    title: 'Logout'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //  Perform logout action
                        Navigator.pop(context);
                        // Close the bottom sheet

                        //logout
                        AuthenticationRepository.instance.logout();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  final Icon icon;
  final String title;

  const CardWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      child: SizedBox(
        height: 50,
        width: 150,
        child: Center(
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class DevicesGridDashboard extends StatelessWidget {
  const DevicesGridDashboard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Passenger Vehicle",
      "Light Truck",
      "Heavy Truck",
      "Motorcyle",
      "Recreational Vehicle",
      "Other",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "Choose Category",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardField(size, Colors.green, passengerVh, 'Passenger', 'Vehicle',
                  () {
                Get.to(
                    () => ProductListByCategoryScreen(category: categories[0]));
              }),
              CardField(size, Colors.amber, lightTruck, 'Light', 'Truck', () {
                Get.to(
                    () => ProductListByCategoryScreen(category: categories[1]));
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardField(size, Colors.teal, HeavyTruck, 'Heavy', 'Truck', () {
                Get.to(
                    () => ProductListByCategoryScreen(category: categories[2]));
              }),
              CardField(size, Colors.purple, Motorcyle, 'Motorcyle', '....',
                  () {
                Get.to(
                    () => ProductListByCategoryScreen(category: categories[3]));
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardField(size, Colors.green, RecreationalVehicle, 'Vacational',
                  'Vehicle', () {
                Get.to(
                    () => ProductListByCategoryScreen(category: categories[4]));
              }),
              CardField(size, Colors.purple, OtherVh, 'View', 'ALL', () {
                Get.to(() => const ProductListScreen());
              }),
            ],
          ),
        ],
      ),
    );
  }
}

CardField(
  Size size,
  Color color,
  // Icon icon,
  //Image image,
  String imageurl,
  String title,
  String subtitle,
  VoidCallback onTap,
) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
      color: Colors.white.withOpacity(0.7),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: size.height * .1,
          width: size.width * .42,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                backgroundImage: AssetImage(imageurl),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 11),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class GCircle extends StatefulWidget {
  Color color;
  GCircle(this.color, {super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GCircle();
  }

  updateColor(Color color) {
    this.color = color;
  }
}

class _GCircle extends State<GCircle> {
  Color c = Colors.black87;
  @override
  void initState() {
    List<Color> colors = [Colors.black, Colors.greenAccent, Colors.cyan];
    Random random = Random();
    Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {
        c = colors[random.nextInt(colors.length)];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundColor: c,
      ),
    ));
  }
}
