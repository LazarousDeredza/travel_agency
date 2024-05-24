import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/model_product.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/product_controller.dart';
import 'package:intl/intl.dart';

class addProductPage extends StatefulWidget {
  const addProductPage({super.key});

  @override
  _addProductPageState createState() => _addProductPageState();
}

class _addProductPageState extends State<addProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _productNameController = TextEditingController();
  final _productDetailsController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productSpeedController = TextEditingController();
  final _productEngineCapacityController = TextEditingController();
  final _productFuelConsumptionController = TextEditingController();
  final _productPowerController = TextEditingController();

  final TextEditingController _dropdownController = TextEditingController();
  String fuelType = 'Diesel';

  @override
  void dispose() {
    _productNameController.dispose();
    _productDetailsController.dispose();
    _productPriceController.dispose();
    _productSpeedController.dispose();
    _productEngineCapacityController.dispose();
    _productFuelConsumptionController.dispose();
    _productPowerController.dispose();
    _dropdownController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dropdownController.text = fuelType ?? "Diesel";
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  String? _onBehalfOf;

  String? _witnesses;
  DateTime? _selectedDate; // Variable to store the selected date
  List<String> urls = [];
  bool isUploading = false;

  String? userID;

  static List<String> categories = [
    "Passenger Vehicle",
    "Light Truck",
    "Heavy Truck",
    "Motorcyle",
    "Recreational Vehicle",
    "Other",
  ];

  String selectedCategory = categories.first;

  uploadDataToFirebase() async {
    // Pick image files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      dialogTitle: "Select Vehicle Images",
    );

    // Show snackbar if no file is selected
    if (result == null || result.files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No File Selected"),
      ));
      return;
    } else if (result.files.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Maximum number of files exceeded (4)"),
      ));
      return;
    } else {
      setState(() {
        isUploading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Uploading Image(s)"),
      ));
    }

    //clear urls
    urls.clear();

    // Upload each file to Firebase Storage
    for (var file in result.files) {
      var path = file.path!;
      var bytes = await File(path).readAsBytes();
      String fileName = path.split('/').last;

      // Uploading file to Firebase Storage
      var reference =
          FirebaseStorage.instance.ref().child("Images").child(fileName);
      UploadTask task = reference.putData(bytes);

      TaskSnapshot snapshot = await task;
      String fileUrl = await snapshot.ref.getDownloadURL();

      // Store the URL in the list
      urls.add(fileUrl);

      // Uploading URL to Firebase Firestore
      await FirebaseFirestore.instance.collection('Images').add({
        'url': fileUrl,
        'name': fileName,
      });
    }

    // Snackbar to indicate file upload completion
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Images Uploaded"),
    ));
    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller2 = Get.put(VehicleController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle for hire'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.always, // Always validate the form

            child: Stack(
              children: [
                if (isUploading) const LinearProgressIndicator(),
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    if (isUploading)
                      const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Center(
                              child: Text(
                                "Uploading Image(s)...",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                          LinearProgressIndicator(),
                        ],
                      ),
                    const SizedBox(height: 16.0),
                    Card(
                      shape: const RoundedRectangleBorder(),
                      color: Colors.yellow.shade100,
                      child: Text(
                        "Fill In below to add a new vehicle",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const Divider(
                      thickness: .9,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _productNameController,
                      decoration: const InputDecoration(
                        labelText: 'Add Vehicle Name',
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter the vehicle name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _productDetailsController,
                      maxLines: 4,
                      maxLength: 150,
                      decoration: InputDecoration(
                        labelText: 'Vehicle Details',
                        border: OutlineInputBorder(
                          // Added border to the text field
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the vehicle details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Vehicle Price/Hr',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide  Price/Hr';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

//_productSpeedController
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              controller: _productSpeedController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Vehicle Speed Km/hr',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide vehicle Speed Km/hr';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(width: 16.0),
                          //fuelType radio
                          Column(
                            children: [
                              const Text(
                                "Fuel Type",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: DropdownButtonFormField<String>(
                                  value: fuelType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      fuelType = newValue!;
                                      _dropdownController.text = newValue ?? "";
                                    });
                                  },
                                  items: <String>["Diesel", "Petrol"]
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: _productEngineCapacityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Vehicle Engine Capacity',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide vehicle Engine Capacity';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          "CC",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: _productFuelConsumptionController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Vehicle Fuel Consumption',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide  Vehicle Fuel Consumption';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          "L/KM",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: _productPowerController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Vehicle Horse Power',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide  Vehicle Power';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          "HP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),

                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Select Vehicle Category"),
                    )),
                    Center(
                      child: DropdownMenu<String>(
                        initialSelection: categories.first,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value!;
                            print(value);
                          });
                        },
                        dropdownMenuEntries: categories
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry(value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Please Upload Vehicle Images (max 4 images)',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print("IsUploading = true");

                        setState(() {
                          isUploading =
                              true; // Set isUploading to true before uploading
                        });

                        // Call the uploadDataToFirebase() method
                        await uploadDataToFirebase();

                        setState(() {
                          isUploading =
                              false; // Set isUploading to false after uploading
                        });

                        print("Isuploading = false ");
                      },
                      child: const Text("Upload"),
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: isUploading
                          ? () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Please wait for Images to finish uploading"),
                              ));
                              return;
                            }
                          : () {
                              if (urls.isEmpty || urls.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Please upload at least one Vehicle[] Image"),
                                ));
                                return;
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Process the form data

                                  Vehicle product = Vehicle(
                                    dateAdded: _formatDateTime(
                                        DateTime.now().toString()),
                                    productName: _productNameController.text,
                                    productDetails:
                                        _productDetailsController.text,
                                    productCategory: selectedCategory,
                                    productImages: urls,
                                    productPrice: _productPriceController.text,
                                    hired: false,
                                    topSpeed: _productSpeedController.text,
                                    fuelType:
                                        _dropdownController.text == "Diesel"
                                            ? "Diesel"
                                            : "Petrol",
                                    engineCapacity:
                                        _productEngineCapacityController.text,
                                    fuelConsumption:
                                        _productFuelConsumptionController.text,
                                    power: _productPowerController.text,
                                  );

                                  print(product.toJson());
                                  controller2.saveProduct(product);
                                  wipeData();
                                  //Get.to(() => ReportCorruptionScreen());
                                }
                              }
                            },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static String generateRandomString() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String randomString = '';

    for (var i = 0; i < 6; i++) {
      final randomIndex = random.nextInt(chars.length);
      randomString += chars[randomIndex];
    }

    print("generated code id $randomString");

    return randomString;
  }

  void wipeData() {
    _productNameController.clear();
    _productDetailsController.clear();
    _productPriceController.clear();

    urls.clear();
  }
}
