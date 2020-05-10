import 'package:http/http.dart' as http;
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/userData.dart';
import 'package:transport_booking_system_passenger_mobile/constants.dart';
import 'package:transport_booking_system_passenger_mobile/models/newUserRegister.dart';
import 'dart:convert';

import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/models/passenger.dart';

class AuthController {
  
  Future<APIResponse<String>> registerPassenger(NewUserRegister newUserModel) async {
    String url = Constants.SERVER + '/signup';
    String phoneNumberSend = "+94" + newUserModel.phoneNumber.toString().substring(1);
    var body = jsonEncode(<String, String>{
      "firstName": newUserModel.firstName,
      "secondName": newUserModel.secondName,
      "email": newUserModel.email,
      "password": newUserModel.password,
      "phoneNumber": phoneNumberSend,
      "role": newUserModel.role
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    return http.post(
      url,
      headers: headers,
      body: body
    ).then((response){
      if(response.statusCode == 200) {
        Map<String, dynamic> message = jsonDecode(response.body);
        return APIResponse<String>(data: message["message"]);
      } else {
        final error = jsonDecode(response.body);
        return APIResponse<String>(error: true, errorMessage: error['error']);
      }
    }).
    catchError((error) => APIResponse<String> (error: true, errorMessage: 'An error occured')); 
  }

  Future<APIResponse<UserData>> signInPassenger(String email, String password) async {
    // sign in the passenger when the email and password is given
    String url = Constants.SERVER;
    return http.post(
      '$url/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      })
    ).then ((response) {
        print ('status code' + response.statusCode.toString());
        if(response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          // convert the response to a custom user object
          if (UserData.fromJson(data).role == "PASSENGER") { 
            print (UserData.fromJson(data).uid);
            print (UserData.fromJson(data).phoneNumber);
            print (UserData.fromJson(data).role);
            return APIResponse<UserData>(data: UserData.fromJson(data)); 
          } else {
            return APIResponse<UserData>(error: true, errorMessage: 'Not a valid passenger');
          }
        }
        if(response.statusCode == 400) {
          final error = jsonDecode(response.body);
          return APIResponse<UserData>(error: true, errorMessage: error['error']);
        }
        return APIResponse<UserData>(error: true, errorMessage: 'An error occured');
      }).
      catchError((error) => APIResponse<UserData> (error: true, errorMessage: 'An error occured')); 
  }
   APIResponse<List<BusTripData>> getBusTripDetails(String startingDestination, String endingDestination, String journeyDate) {
    // get the details of the buses when the starting city, ending destination, and journey date is given 
    List<BusSeat> busSeatDetails = [
      BusSeat(seatID: '1',booked: true, passenger: Passenger(passengerName: "passenger1", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '2',booked: true, passenger: Passenger(passengerName: "passenger2", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '3',booked: true, passenger: Passenger(passengerName: "passenger3", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '4',booked: true, passenger: Passenger(passengerName: "passenger4", boardingCity: "Kurunegala", destinationCity: "Jaffna")),
      BusSeat(seatID: '5',booked: true, passenger: Passenger(passengerName: "passenger5", boardingCity: "Gampaha", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '6',booked: false, passenger: null),
      BusSeat(seatID: '7',booked: true, passenger: Passenger(passengerName: "passenger7", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '8',booked: true, passenger: Passenger(passengerName: "passenger8", boardingCity: "Gampaha", destinationCity: "Jaffna")),
      BusSeat(seatID: '9',booked: true, passenger: Passenger(passengerName: "passenger9", boardingCity: "Gampaha", destinationCity: "Jaffna")),
      BusSeat(seatID: '10',booked: true, passenger: Passenger(passengerName: "passenger10", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '11',booked: false, passenger: null),
      BusSeat(seatID: '12',booked: true, passenger: Passenger(passengerName: "passenger12", boardingCity: "Kurunegala", destinationCity: "Jaffna")),
      BusSeat(seatID: '13',booked: true, passenger: Passenger(passengerName: "passenger13", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '14',booked: true, passenger: Passenger(passengerName: "passenger14", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '15',booked: false, passenger: null),
      BusSeat(seatID: '16',booked: false, passenger: null),
      BusSeat(seatID: '17',booked: true, passenger: Passenger(passengerName: "passenger17", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '18',booked: true, passenger: Passenger(passengerName: "passenger18", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '19',booked: true, passenger: Passenger(passengerName: "passenger19", boardingCity: "Kurunegala", destinationCity: "Jaffna")),
      BusSeat(seatID: '20',booked: true, passenger: Passenger(passengerName: "passenger20", boardingCity: "Kurunegala", destinationCity: "Jaffna")),
      BusSeat(seatID: '21',booked: true, passenger: Passenger(passengerName: "passenger21", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '22',booked: false, passenger: null),
      BusSeat(seatID: '23',booked: true, passenger: Passenger(passengerName: "passenger23", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '24',booked: true, passenger: Passenger(passengerName: "passenger24", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '25',booked: true, passenger: Passenger(passengerName: "passenger25", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '26',booked: true, passenger: Passenger(passengerName: "passenger26", boardingCity: "Colombo", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '27',booked: true, passenger: Passenger(passengerName: "passenger27", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '28',booked: true, passenger: Passenger(passengerName: "passenger28", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '29',booked: true, passenger: Passenger(passengerName: "passenger29", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '30',booked: true, passenger: Passenger(passengerName: "passenger30", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '31',booked: true, passenger: Passenger(passengerName: "passenger31", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '32',booked: true, passenger: Passenger(passengerName: "passenger32", boardingCity: "Gampaha", destinationCity: "Anuradhapura")),
      BusSeat(seatID: '33',booked: true, passenger: Passenger(passengerName: "passenger33", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '34',booked: true, passenger: Passenger(passengerName: "passenger34", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '35',booked: true, passenger: Passenger(passengerName: "passenger35", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '36',booked: true, passenger: Passenger(passengerName: "passenger36", boardingCity: "Kurunegala", destinationCity: "Jaffna")),
      BusSeat(seatID: '37',booked: true, passenger: Passenger(passengerName: "passenger37", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '38',booked: true, passenger: Passenger(passengerName: "passenger38", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '39',booked: true, passenger: Passenger(passengerName: "passenger39", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '40',booked: true, passenger: Passenger(passengerName: "passenger40", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '41',booked: true, passenger: Passenger(passengerName: "passenger41", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '42',booked: false, passenger: null),
      BusSeat(seatID: '43',booked: true, passenger: Passenger(passengerName: "passenger43", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '44',booked: true, passenger: Passenger(passengerName: "passenger44", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '45',booked: true, passenger: Passenger(passengerName: "passenger45", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '46',booked: false, passenger: null),
      BusSeat(seatID: '47',booked: true, passenger: Passenger(passengerName: "passenger47", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '48',booked: false, passenger: null),
      BusSeat(seatID: '49',booked: true, passenger: Passenger(passengerName: "passenger49", boardingCity: "Gampaha", destinationCity: "Jaffna")),
      BusSeat(seatID: '50',booked: true, passenger: Passenger(passengerName: "passenger50", boardingCity: "Gampaha", destinationCity: "Vavuniya")),
      BusSeat(seatID: '51',booked: false, passenger: null),
      BusSeat(seatID: '52',booked: true, passenger: Passenger(passengerName: "passenger52", boardingCity: "Colombo", destinationCity: "Jaffna")),
      BusSeat(seatID: '53',booked: false, passenger: null),
      BusSeat(seatID: '54',booked: true, passenger: Passenger(passengerName: "passenger54", boardingCity: "Gampaha", destinationCity: "Jaffna")),
    ];

    List<BusTripData> buses = [
      BusTripData(
        busNumber: 'NA1023', 
        busType: 'Type1', 
        routeNumber: '87/759',
        startingDestination: 'Colombo',
        endingDestination: "Jaffna",
        startingDateTime: '10 May - 8.00am',
        endingDateTime: '10 May - 5.00pm',
        seatPrice: 'LKR 1700',
        busSeatDetails: busSeatDetails.sublist(0,49),
      ),
      BusTripData(
        busNumber: 'NA2323', 
        busType: 'Type2', 
        routeNumber: '87/759',
        startingDestination: 'Colombo',
        endingDestination: "Jaffna",
        startingDateTime: '10 May - 11.00am',
        endingDateTime: '10 May - 8.00pm',
        seatPrice: 'LKR 1500',
        busSeatDetails: busSeatDetails.sublist(0,30),
      ),
      BusTripData(
        busNumber: 'NA3523', 
        busType: 'Type3', 
        routeNumber: '87/759',
        startingDestination: 'Colombo',
        endingDestination: "Jaffna",
        startingDateTime: '10 May - 5.00pm',
        endingDateTime: '11 May - 2.00am',
        seatPrice: 'LKR 1000',
        busSeatDetails: busSeatDetails,
      ),
      BusTripData(
        busNumber: 'NA4623', 
        busType: 'Type4', 
        routeNumber: '87/759',
        startingDestination: 'Colombo',
        endingDestination: "Jaffna",
        startingDateTime: '10 May - 10.00pm',
        endingDateTime: '11 May - 7.00am',
        seatPrice: 'LKR 1000',
        busSeatDetails: busSeatDetails.sublist(0,44),
      ),
    ];
    return APIResponse<List<BusTripData>>(data: buses); 
  }
}

