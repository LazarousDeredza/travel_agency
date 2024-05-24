import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/details/constant.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/view_image.dart';

class AllHirings extends StatefulWidget {
  const AllHirings({super.key});

  @override
  _AllHiringsState createState() => _AllHiringsState();
}

class _AllHiringsState extends State<AllHirings> {
  final TextEditingController _searchController = TextEditingController();

  String id = "";
  String searchQuery = "";
  bool _isLoading = false;

  bool hasData = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Hirings')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        //set hasData if there is data
        hasData = snapshot.docs.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search here...',
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            //clear icon
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              id = value;
              searchQuery = value;
            });
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Hirings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // Retrieve cart list from Firebase
            final filteredProducts = snapshot.data!.docs.where((x) {
              final productId = x.id.toLowerCase() +
                  x['productName'].toString().toLowerCase() +
                  x['productCategory'].toString().toLowerCase() +
                  x['dateAdded'].toString().toLowerCase() +
                  x['productDetails'].toString().toLowerCase() +
                  x['productPrice'].toString().toLowerCase();

              final searchQuery = _searchController.text.toLowerCase();
              return productId.contains(searchQuery);
            }).toList();

            return Column(
              children: [
                //Display cart list
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final cartItem = filteredProducts[index];

                      QueryDocumentSnapshot x = filteredProducts[index];

                      //list of image urls

                      // final pImages = x['productImages'];
                      // List<String>? productImages;
                      // if (pImages is List<dynamic>) {
                      //   productImages = pImages.cast<String>().toList();

                      // }

                      final productImages = x['productImages'];

                      List<String>? castedProductImageUrls;
                      if (productImages is List<dynamic>) {
                        castedProductImageUrls =
                            productImages.cast<String>().toList();
                      }
                      String dateAdded = x['dateAdded'];
                      String trimmedDateAdded = dateAdded.substring(0, 16);

                      //String endDateString = x['endDate'];

                      /// Assuming x['endDate'] is a Timestamp object
                      Timestamp endDateTimestamp = x['endDate'];

// Convert the Timestamp to a DateTime object
                      DateTime endDate = endDateTimestamp.toDate();

// Define the desired date format
                      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

// Format the DateTime object to a string in the desired format
                      String formattedEndDate = dateFormat.format(endDate);

// Print the formatted date
                      print(formattedEndDate);

                      return Column(
                        children: [
                          Center(
                            child: Text(
                              "  ${x['firstName']} ${x['lastName']}" +
                                  "\n" +
                                  trimmedDateAdded +
                                  "  - " +
                                  formattedEndDate,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/home.png"),
                                const SizedBox(width: 5),
                                Text(x['productName'], style: kCarTitle),
                              ],
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: castedProductImageUrls!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyImageWidget(
                                                  imageUrl:
                                                      castedProductImageUrls![
                                                          index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            castedProductImageUrls![index],
                                            width: 350,
                                            height: 310,
                                            fit: BoxFit.fill,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 49, 16, 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Description', style: kSectionTitle),
                                const SizedBox(height: 10),
                                Text(
                                  x['productDetails'],
                                  style: kBrand.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Fuel Type', style: kSectionTitle),
                                const SizedBox(height: 10),
                                Text(
                                  x['fuelType'],
                                  style: kBrand.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Specs', style: kSectionTitle),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/speed.png'),
                                          const SizedBox(height: 3),
                                          Text(x['topSpeed'] + " Km/Hr",
                                              style: kBrand),
                                          const SizedBox(height: 3),
                                          Text(
                                            'Max. Speed',
                                            style: kBrand.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/seat.png'),
                                          const SizedBox(height: 3),
                                          Text(x['power'] + " HH",
                                              style: kBrand),
                                          const SizedBox(height: 3),
                                          Text(
                                            'Horse Power',
                                            style: kBrand.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/engine.png'),
                                          const SizedBox(height: 3),
                                          Text(x['engineCapacity'] + " CC",
                                              style: kBrand),
                                          const SizedBox(height: 3),
                                          Text(
                                            'Engine Capacity',
                                            style: kBrand.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/engine.png'),
                                          const SizedBox(height: 3),
                                          Text(x['fuelConsumption'] + " L/Km",
                                              style: kBrand),
                                          const SizedBox(height: 3),
                                          Text(
                                            'Fuel Consumption',
                                            style: kBrand.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              "Total amount : \$" + x['totalAmount'],
                              style: kCarTitle,
                            ),
                          ),
                          const Center(
                            child: Text("Paid using Ecocash"),
                          ),
                          const SizedBox(height: 20),
                          if (x['hired'])
                            ElevatedButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Releasing Vehicle')));

                                final db = FirebaseFirestore.instance;

                                await db
                                    .collection("vehicles")
                                    .doc(x['id'])
                                    .update({"hired": false});
                                await db
                                    .collection("Hirings")
                                    .doc(x.id)
                                    .update({"hired": false});

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Vehicle Released Sucessfully')),
                                );
                              },
                              child: const Text("Release"),
                            ),
                          const SizedBox(height: 20),
                          const Divider(
                            height: 2.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                //textView Total amount

                const SizedBox(
                  height: 10.0,
                ),
                // Checkout button
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}