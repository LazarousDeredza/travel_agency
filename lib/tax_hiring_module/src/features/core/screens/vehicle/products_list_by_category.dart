import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/add_product.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/details/screens/detail.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/view_product.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/services/widgets/widgets.dart';
import 'package:travel_agency/tax_hiring_module/src/repository/authentication_repository/authentication_repository.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  ProductListByCategoryScreen({super.key, required this.category});

  String category;

  @override
  State<ProductListByCategoryScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListByCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String howItWasresolved = "";
  String id = "";
  String searchQuery = "";

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    print(widget.category);

    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        if (value.data()!["level"] == "admin") {
          isAdmin = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const addProductPage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('vehicles')
            .where('productCategory', isEqualTo: widget.category)
            .orderBy('dateAdded', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final filteredProducts = snapshot.data!.docs.where((x) {
              final productId = x.id.toLowerCase() +
                  x['productName'].toLowerCase() +
                  x['productCategory'].toLowerCase() +
                  x['dateAdded'].toLowerCase() +
                  x['productDetails'].toLowerCase() +
                  x['productPrice'].toLowerCase() +
                  x['hired'].toString().toLowerCase();

              final searchQuery = _searchController.text.toLowerCase();
              return productId.contains(searchQuery);
            }).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot x = filteredProducts[i];

                      //list of image urls

                      final pImages = x['productImages'];

                      String hired = '';
                      if (x['hired'] == true) {
                        hired = 'Hired';
                      } else {
                        hired = 'Available';
                      }

                      print("Hired = $hired");

                      List<CarouselItem> itemList = [];

                      List<String>? productImages;
                      if (pImages is List<dynamic>) {
                        productImages = pImages.cast<String>().toList();

                        for (var element in productImages) {
                          print(element);

                          CarouselItem item = CarouselItem(
                            image: NetworkImage(
                              element,
                            ),
                            boxDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  const Color.fromARGB(255, 3, 105, 28)
                                      .withOpacity(1),
                                  Colors.black.withOpacity(.3),
                                ],
                                stops: const [0.0, 1.0],
                              ),
                            ),
                            title: '${x['productName']}  : $hired',
                            titleTextStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            leftSubtitle:
                                '\$ ${x['productPrice'].toLowerCase()} / hr ',
                            rightSubtitle: '${x['productCategory']}',
                            rightSubtitleTextStyle: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 236, 234, 234),
                            ),
                            onImageTap: (i) {
                              if (x['hired'] == true) {
                                showSnackbar(context, Colors.red,
                                    "This Vehicle is already hired.");
                                return;
                              } else {
                                print("not hired");
                              }
                              print('$i image tapped');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                               DetailScreen(id: x.id),
                                      //ViewProductScreen(productID: x.id),
                                ),
                              );
                            },
                          );

                          itemList.add(item);
                        }
                      }

                      return InkWell(
                        onTap: () {
                          if (x['hired'] == true) {
                            showSnackbar(context, Colors.red,
                                "This Vehicle is already hired.");
                            return;
                          } else {
                            print("not hired");
                          }
                          print("product ID = ${x.id}");
                          // Go to view case screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              DetailScreen(id: x.id),
                                 // ViewProductScreen(productID: x.id),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CustomCarouselSlider(
                              items: itemList,
                              height: 300,
                              subHeight: 50,
                              width: MediaQuery.of(context).size.width * .9,
                              autoplay: true,
                              animationDuration: const Duration(seconds: 3),
                              showText: true,
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Data found"),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // popUpDialog(BuildContext context) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: ((context, setState) {
  //           return AlertDialog(
  //             title: const Text(
  //               "Enter How the case was resolved",
  //               textAlign: TextAlign.left,
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 _isLoading == true
  //                     ? Center(
  //                         child: CircularProgressIndicator(
  //                             color: Theme.of(context).primaryColor),
  //                       )
  //                     : TextField(
  //                         onChanged: (val) {
  //                           setState(() {
  //                             howItWasresolved = val;
  //                           });
  //                         },
  //                         maxLines: 5,
  //                         style: Theme.of(context).textTheme.headlineSmall,
  //                         decoration: InputDecoration(
  //                             hintText: 'Type here...',
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Theme.of(context).primaryColor),
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             errorBorder: OutlineInputBorder(
  //                                 borderSide:
  //                                     const BorderSide(color: Colors.red),
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             focusedBorder: OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Theme.of(context).primaryColor),
  //                                 borderRadius: BorderRadius.circular(20))),
  //                       ),
  //               ],
  //             ),
  //             actions: [
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                     backgroundColor: Theme.of(context).primaryColor),
  //                 child: Text(
  //                   "CANCEL",
  //                   style: Theme.of(context).textTheme.bodyLarge,
  //                 ),
  //               ),
  //               //space
  //               const SizedBox(
  //                 width: 15,
  //               ),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   if (howItWasresolved != "") {
  //                     setState(() {
  //                       _isLoading = true;
  //                     });

  //                     await FirebaseFirestore.instance
  //                         .collection('cases')
  //                         .doc(id)
  //                         .update({
  //                       'status': "Closed",
  //                       'howItWasResolved': howItWasresolved
  //                     });

  //                     setState(() {
  //                       _isLoading = false;
  //                     });

  //                     Navigator.of(context).pop();
  //                     showSnackbar(
  //                         context, Colors.green, "Case Updated successfully.");
  //                   }
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                     backgroundColor: Theme.of(context).primaryColor),
  //                 child: Text(
  //                   "Submit",
  //                   style: Theme.of(context).textTheme.bodyLarge,
  //                 ),
  //               )
  //             ],
  //           );
  //         }));
  //       });
  // }




}
