import 'package:travel_agency/flight_booking_module/flight_model.dart';

class FlightsMockData {

  static var count = 5;

  static var from = ["Harare", "Bulawayo", "Vic Falls", "Hwange", "Mutare"];
  static var to = ["Vic Falls", "Harare", "Hwange", "Masvingo", "Bulawayo"];
  static var fromCity = ["RGB Airport", "Bulawayo", "Vic Falls", "Hwange", "Mutare"];
  static var toCity = ["Harare", "Bulawayo", "Hwange", "Masvingo", "Bulawayo"];
  static var departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
  static var arriveTime = ["8:40 AM", "4:25 PM", "13:00 PM", "5:21 AM", "22:25 PM"];

  static getFlights(int position) {
    return Flight(
        from[position],
        to[position],
        fromCity[position],
        toCity[position],
        departTime[position],
        arriveTime[position]);
  }

}