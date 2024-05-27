import 'package:travel_agency/flight_booking_module/flight_model.dart';

class FlightsMockData {

  static var count = 10;



// "Harare - Robert Gabriel Mugabe International Airport" [2],
// "Bulawayo - Joshua Mqabuko Nkomo International Airport" [1],
// "Victoria Falls - Victoria Falls Airport" [1],
// "Hwange - Hwange National Park Airport" [1],
// "Mutare - Mutare Airport" [1],
// "Masvingo - Masvingo Airport",
// "Gweru - Thornhill Air Base",
// "Kariba - Kariba Airport",
// "Chiredzi - Buffalo Range Airport",
// "Beitbridge - Beitbridge Airport"



// "Robert Gabriel Mugabe International Airport",
// "Joshua Mqabuko Nkomo International Airport",
// "Victoria Falls Airport",
// "Hwange National Park Airport",
// "Mutare Airport",
// "Masvingo Airport",
// "Thornhill Air Base",
// "Kariba Airport",
// "Buffalo Range Airport",
// "Beitbridge Airport",

// "Beitbridge",
// "Chiredzi",
// "Kariba",
// "Gweru",
// "Masvingo",
// "Mutare",
// "Hwange",
// "Victoria Falls",
// "Bulawayo",
// "Harare",



  static var from = ["Harare","Bulawayo","Victoria Falls","Hwange","Mutare","Masvingo","Gweru","Kariba","Chiredzi","Beitbridge"];
  static var to = ["Beitbridge","Chiredzi","Kariba","Gweru","Masvingo","Mutare","Hwange","Victoria Falls","Bulawayo","Harare",];
  static var fromCity = ["Robert Gabriel Mugabe International Airport","Joshua Mqabuko Nkomo International Airport","Victoria Falls Airport",
"Hwange National Park Airport","Mutare Airport","Masvingo Airport","Thornhill Air Base","Kariba Airport","Buffalo Range Airport","Beitbridge Airport",];
  static var toCity = ["Beitbridge Airport","Buffalo Range Airport","Kariba Airport","Thornhill Air Base","Masvingo Airport","Mutare Airport",
"Hwange National Park Airport","Victoria Falls Airport","Joshua Mqabuko Nkomo International Airport","Robert Gabriel Mugabe International Airport"];
  static var departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM","5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
  static var price=[200,280,150,300,260,200,280,150,300,260];
  static var arriveTime = ["8:40 AM", "4:25 PM", "13:00 PM", "5:21 AM", "22:25 PM","8:40 AM", "4:25 PM", "13:00 PM", "5:21 AM", "22:25 PM"];

  static getFlights(int position) {
    return Flight(
        from[position],
        to[position],
        fromCity[position],
        toCity[position],
          price[position],
        departTime[position],      
        arriveTime[position]);
  }

}