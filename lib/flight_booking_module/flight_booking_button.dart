import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/flight_booking_module/flight_model.dart';
import 'package:travel_agency/flight_booking_module/flight_order_paid_screen.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';


class FlightBookingButton extends StatefulWidget {
  final Flight flight;
  final int totalAmount;
  final String fightNumber;
  final String StartDate;
  final int numberOfPassengers;

  const FlightBookingButton(
      {required this.flight,
      required this.totalAmount,
      required this.fightNumber,
      required this.StartDate,
     
      required this.numberOfPassengers,
      super.key});

  @override
  State<FlightBookingButton> createState() => _FlightBookingButtonState();
}

class _FlightBookingButtonState extends State<FlightBookingButton> {
  String payingphone = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 28.v),
      decoration: AppDecoration.outlineGray,
      child: ElevatedButton(
        onPressed: () {
          popUpDialog(context, widget.flight, widget.totalAmount,
              widget.fightNumber, widget.StartDate);

         
        },
        child: Text("Pay"),
      ),
    );
  }

  popUpDialog(BuildContext context, Flight flight, int totalAmount,
      String selectedOption, String startDate) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              scrollable: true,
              actionsAlignment: MainAxisAlignment.center,
              alignment: Alignment.center,
              icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ),
              title: Text(
                "Payment for Flight : " + widget.fightNumber,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Flying : " + "Commercial"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Number Of Passengers : " + widget.numberOfPassengers.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    Text("From : " + widget.flight.from.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    Text("To : " + widget.flight.to.toString()),

                    SizedBox(
                      height: 10,
                    ),
                    Text("Amount : \$" + widget.totalAmount.toString()),

                    _isLoading == true
                        ? Center(
                            child: Column(
                              children: [
                                Text(
                                  "Processing payment...",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    //paying phone number
                    _isLoading == true
                        ? Container()
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                payingphone = val;
                              });
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                ),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Ecocash Phone Number',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                    const SizedBox(height: 10),
                    //total amount
                    
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Proceed To Payment"),
                    ),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    if (payingphone.length < 10 || payingphone.length > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Invalid Phone Number \nuse format 077xxxxxxxx'),
                        ),
                      );
                      return;
                    }

                    if (payingphone != "0771111111" &&
                        payingphone != "0772222222" &&
                        payingphone != "0773333333" &&
                        payingphone != "0774444444") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'This application is using paynow in test mode . Please use paynow test numbers'),
                        ),
                      );

                      return;
                    }

                    if (payingphone == "0774444444") {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 20 ~/ 2));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'There are insufficient funds in your account'),
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop();

                      return;
                    }

                    if (payingphone == "0773333333") {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 20 ~/ 2));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment Failed . User canceled'),
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop();

                      return;
                    }

                    if (payingphone != "0771111111" ||
                        payingphone != "0772222222") {
                      setState(() {
                        _isLoading = true;
                      });

                     Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Payment \& Booking Successful'),
                        ),
                      );
                      setState(() {
                        _isLoading = false;
                      });

                      Get.to(() => FlightOrderPaidScreen());

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => const TaxHome()));

                      return;
                    }

                   
                  },
                  child: Image.asset(
                    'assets/images/pay_with_ecocash.png',
                    width: 150,
                  ),
                ),
              ],
            );
          }));
        });
  }
}
