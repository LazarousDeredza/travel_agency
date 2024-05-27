import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/flight_booking_module/flight_list_screen.dart';


class FlightBookingHomeScreen extends StatefulWidget{
  @override
  FlightBookingHomeScreenState createState() {
    return  FlightBookingHomeScreenState();
  }
}


class FlightBookingHomeScreenState extends State<FlightBookingHomeScreen> {

  final nameController = TextEditingController();



  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(50.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 150.0,

                ),
                SizedBox(height: 20.0,),
                Text("BookMyFlights",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50.0,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius:BorderRadius.circular(20.0)),
                      hintText: "Full Name",
                      filled: true,
                      fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0)
                  ),

                  // onChanged listener listens to every change to textfield
//              onChanged: (text){
//                print(text);
//              },

                ),
                SizedBox(height: 10.0,),
                ElevatedButton(
                  child:  Text("Proceed"),
                  onPressed: (){
                   Get.to(() => FlightListScreen(fullName : nameController.text));
                  },

                ),

              ],
            ),
          ],
        )
      ),
    );
  }
}