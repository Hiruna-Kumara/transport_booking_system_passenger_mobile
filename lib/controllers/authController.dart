import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/routeDataGetById.dart';
import 'package:transport_booking_system_passenger_mobile/models/routesDropdown.dart';
import 'package:transport_booking_system_passenger_mobile/models/userData.dart';
import 'package:transport_booking_system_passenger_mobile/constants.dart';
import 'package:transport_booking_system_passenger_mobile/models/newUserRegister.dart';
import 'dart:convert';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/models/route.dart';

import 'package:transport_booking_system_passenger_mobile/models/busBookingData.dart';

class AuthController {
  Future<APIResponse<String>> registerPassenger(
      NewUserRegister newUserModel) async {
    String url = Constants.SERVER + '/signup';
    String phoneNumberSend =
        "+94" + newUserModel.phoneNumber.toString().substring(1);
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
    return http.post(url, headers: headers, body: body).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> message = jsonDecode(response.body);
        return APIResponse<String>(data: message["message"]);
      } else {
        final error = jsonDecode(response.body);
        return APIResponse<String>(error: true, errorMessage: error['error']);
      }
    }).catchError((error) =>
        APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<UserData>> signInPassenger(
      String email, String password) async {
    // sign in the passenger when the email and password is given
    String url = Constants.SERVER;
    return http
        .post('$url/signin',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'email': email, 'password': password}))
        .then((response) {
      print('status code' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // convert the response to a custom user object
        if (UserData.fromJson(data).role == "PASSENGER") {
          print(UserData.fromJson(data).uid);
          print(UserData.fromJson(data).phoneNumber);
          print(UserData.fromJson(data).role);
          print(UserData.fromJson(data).token);
          return APIResponse<UserData>(data: UserData.fromJson(data));
        } else {
          return APIResponse<UserData>(
              error: true, errorMessage: 'Not a valid passenger');
        }
      }
      if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<UserData>(error: true, errorMessage: error['error']);
      }
      return APIResponse<UserData>(
          error: true, errorMessage: 'An error occured');
    }).catchError((error) => APIResponse<UserData>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<List<RouteData>>>> getRoutes(
      String startingStation, String endingStation, String date) async {
    // get the current and upcoming active turns assigned to the conductor
    String url = Constants.SERVER;
    List<List<RouteData>> fullRoute = [];
    List<RouteData> partialRoute = [];
    print('dateee');
    print(date);
    return http
        .post('$url/getroute',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'origin': startingStation,
              'destination': endingStation,
              'date': date,
            }))
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data["routes"]["steps"].length; i++) {
          for (var j = 0; j < data["routes"]["steps"][i].length; j++) {
            print (data["routes"]["steps"][i][j]);
            partialRoute.add(RouteData.fromJson(data["routes"]["steps"][i][j]));
          }
          fullRoute.add(partialRoute);
          partialRoute = [];
        }
        return APIResponse<List<List<RouteData>>>(data: fullRoute);
      }
      if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(
            error: true, errorMessage: error['error']);
      }
      if (response.statusCode == 404) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(
            error: true, errorMessage: error['message']);
      }
      if (response.statusCode == 422) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(
            error: true, errorMessage: error['error']);
      }
      return APIResponse<List<List<RouteData>>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((error) => APIResponse<List<List<RouteData>>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<RouteDataGetById>>> getTurnByRouteID(
      String routeId) async {
    // get the current and upcoming active turns assigned to the conductor
    String url = Constants.SERVER;
    // String url =
        // "https://us-central1-transport-booking-system-62ea6.cloudfunctions.net/app/api";
    // List<List<RouteDataGetById>> fullRoute = [];
    List<RouteDataGetById> partialRoutes = [];
    print('getTurnbyId');
    // print (date);
    return http
        .post('$url/getturnbyroute',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              // 'origin': startingStation,
              // 'destination': endingStation,
              // 'date': date,
              'routeId': routeId,
            }))
        .then((response) {
          print("a");
      if (response.statusCode == 200) {
        print('b');
        Map<String, dynamic> data = jsonDecode(response.body);
        print('c');
        print(data['turns']==null);
        if(data['turns']==null){
print("null");
        }else{
        for (var i = 0; i < data["turns"].length; i++) {
          print('d');
          print(data['turns'][i]);
          partialRoutes.add(RouteDataGetById.fromJson(data['turns'][i]));
          print('e');
          // print("printing partial");
// print (partialRoute);
          // fullRoute.add(partialRoute);
          // partialRoute = [];
        }}
        print('f');
        return APIResponse<List<RouteDataGetById>>(data: partialRoutes);
      }
      print('200 passed');
      if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<RouteDataGetById>>(
            error: true, errorMessage: error['error']);
      }
      if (response.statusCode == 404) {
        final error = jsonDecode(response.body);
        return APIResponse<List<RouteDataGetById>>(
            error: true, errorMessage: error['message']);
      }
      if (response.statusCode == 422) {
        final error = jsonDecode(response.body);
        return APIResponse<List<RouteDataGetById>>(
            error: true, errorMessage: error['error']);
      }
      return APIResponse<List<RouteDataGetById>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((error) => APIResponse<List<RouteDataGetById>>(
            error: true, errorMessage: 'An error occured catch'));
  }

  Future<APIResponse<List<RoutesDropdown>>> routesDropdownDisplay() async {
    // get the current and upcoming active turns assigned to the conductor
    // String url = Constants.SERVER;
    String url =
        "https://us-central1-transport-booking-system-62ea6.cloudfunctions.net/app/api";
    // List<List<RouteDataGetById>> fullRoute = [];
    List<RoutesDropdown> partialRoute = [];
    print('getTurnbyId');
    // print (date);
    final response= await http.get('$url/getallroutes',headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},);
            
     if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data["routes"].length; i++) {
          partialRoute.add(RoutesDropdown.fromJson(data["routes"][i]));

          // fullRoute.add(partialRoute);
          // partialRoute = [];
        }
        return APIResponse<List<RoutesDropdown>>(data: partialRoute);
      }else{
        final error = jsonDecode(response.body);
        return APIResponse<List<RoutesDropdown>>(
            error: true, errorMessage: error['error']);
      }
            

            // final responseJson = json.decode(response.body);

  // return APIResponse<List<RoutesDropdown>>;z
            
        // .then((response) {

      // if (response.statusCode == 200) {
      //   Map<String, dynamic> data = jsonDecode(response.body);
      //   for (var i = 0; i < data["turns"].length; i++) {
      //     partialRoute.add(RouteDataGetById.fromJson(data["turns"][i]));

      //     // fullRoute.add(partialRoute);
      //     // partialRoute = [];
      //   }
      //   return APIResponse<List<RouteDataGetById>>(data: partialRoute);
      // }
      // if (response.statusCode == 400) {
      //   final error = jsonDecode(response.body);
      //   return APIResponse<List<RouteDataGetById>>(
      //       error: true, errorMessage: error['error']);
      // }
      // if (response.statusCode == 404) {
      //   final error = jsonDecode(response.body);
      //   return APIResponse<List<RouteDataGetById>>(
      //       error: true, errorMessage: error['message']);
      // }
      // if (response.statusCode == 422) {
      //   final error = jsonDecode(response.body);
      //   return APIResponse<List<RouteDataGetById>>(
      //       error: true, errorMessage: error['error']);
      // }
      // return APIResponse<List<RouteDataGetById>>(
          // error: true, errorMessage: 'An error occured');
          
    // }).catchError((error) => APIResponse<List<RouteDataGetById>>(
    //         error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<BusTripData>>> getTurns(String routeId) async {
    // get the details of the passenger who booked a particular seat
    // String url = Constants.SERVER;
    List<BusTripData> turns = [];

    // return http.post(
    //   '$url/getturnbyroute',

    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'routeId': routeId,
    //   })
    // ).then ((response) {
    //   if(response.statusCode == 200) {
    //     Map<String, dynamic> data = jsonDecode(response.body);
    //     if (data["turns"] != null && data["turns"].length > 0){
    //       for(var i=0; i<data["turns"].length;i++){
    //         turns.add(BusTripData.fromJson(data["turns"][i]));
    //       }
    //       return APIResponse<List<BusTripData>>(data: turns);
    //     } else {
    //       return APIResponse<List<BusTripData>>(error: true, errorMessage: "No turns");
    //     }
    //   }
    //   if(response.statusCode == 400) {
    //     final error = jsonDecode(response.body);
    //     return APIResponse<List<BusTripData>>(error: true, errorMessage: error['error']);
    //   }
    //   return APIResponse<List<BusTripData>>(error: true, errorMessage: 'An error occured');
    // }).
    // catchError((error) => APIResponse<List<BusTripData>>(error: true, errorMessage: 'An error occured'));

    // BusTripData trip1 = BusTripData(
    //     tripId: "rNJngMhzfcJO5qyOjM9I 2020-05-11T07:00:00.000Z",
    //     departureTime: "2020-05-11T07:00:00.000Z",
    //     startStation: "Colombo",
    //     arrivalTime: "2020-05-11T11:00:00.000Z",
    //     endStation: "Kandy",
    //     normalSeatPrice: 159,
    //     busType: "2x2 bus");
    // BusTripData trip2 = BusTripData(
    //     tripId: "IB5CS5JD7foW57HVUVFo 2020-06-13T07:00:00.750Z",
    //     departureTime: "2020-06-13T07:00:00.750Z",
    //     startStation: "Kurunegala",
    //     arrivalTime: "2020-06-13T10:15:00.750Z",
    //     endStation: "Colombo",
    //     normalSeatPrice: 200,
    //     busType: "3x2 bus");
    

  BusTripData trip1 = BusTripData(
      tripId: "rNJngMhzfcJO5qyOjM9I 2020-05-11T07:00:00.000Z",
      departureTime: "2020-05-11T07:00:00.000Z",
      startStation: "Colombo",
      arrivalTime: "2020-05-11T11:00:00.000Z",
      endStation: "Kandy",
      normalSeatPrice: 159,
      busType: "2x2 bus"
    );
    BusTripData trip2 = BusTripData(
      tripId: "IB5CS5JD7foW57HVUVFo 2020-06-11T07:00:00.750Z",
      departureTime: "2020-06-11T07:00:00.750Z",
      startStation: "Kurunegala",
      arrivalTime: "2020-06-11T10:15:00.750Z",
      endStation: "Colombo",
      normalSeatPrice: 200,
      busType: "3x2 bus"
    );
    BusTripData trip3 = BusTripData(
      tripId: "IB5CS5JD7foW57HVUVFo 2020-06-13T07:00:00.750Z",
      departureTime: "2020-06-13T07:00:00.750Z",
      startStation: "Kurunegala",
      arrivalTime: "2020-06-13T10:15:00.750Z",
      endStation: "Colombo",
      normalSeatPrice: 200,
      busType: "3x2 bus"
    );
    BusTripData trip4 = BusTripData(
      tripId: "IB5CS5JD7foW57HVUVFo 2020-06-14T07:00:00.750Z",
      departureTime: "2020-06-14T07:00:00.750Z",
      startStation: "Kurunegala",
      arrivalTime: "2020-06-14T10:15:00.750Z",
      endStation: "Colombo",
      normalSeatPrice: 200,
      busType: "3x2 bus"
    );
    turns = [trip1, trip2, trip3, trip4];

    // turns = [trip1, trip2];
    return APIResponse<List<BusTripData>>(data: turns);
  }
    




Future<APIResponse<String>> addToWaitingList(String uid, String token, String tripId) async {
    // sign in the passenger when the email and password is given
    String url = Constants.SERVER;
    return http.post(
      '$url/addtowaiting/$uid',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'turnId': tripId,
      })
    ).then ((response) {
        if(response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          return APIResponse<String>(data: data['message']); 
        }
        if(response.statusCode == 400) {
          final error = jsonDecode(response.body);
          return APIResponse<String>(error: true, errorMessage: error['message']);
        }
        return APIResponse<String>(error: true, errorMessage: 'An error occured');
      }).
      catchError((error) => APIResponse<String> (error: true, errorMessage: 'An error occured')); 
  }


  Future<APIResponse<List<BusSeat>>> getBookings(
      String uid, String loginToken, String tripId) async {
    // get the current seat bookings of the trip
    String url = Constants.SERVER;
    String token = loginToken;
    List<BusSeat> seatBookings = [];
    List<BusSeat> orderedSeatBookings = [];

    return http
        .post('$url/getseatsdetailspassenger/$uid',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, String>{
              'turnId': tripId,
              
            }))
        .then((response) {
          print("11");
      if (response.statusCode == 200) {
        print("1");
        Map<String, dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data["seats"].length; i++) {
          print("2");
          seatBookings.add(BusSeat.fromJson(data["seats"][i]));
        }
        for (var i = 0; i < seatBookings.length; i++) {
          print("3");
          for (var j = 0; j < seatBookings.length; j++) {
            if (int.parse(seatBookings[j].seatID) == i + 1) {
              orderedSeatBookings.add(seatBookings[j]);
              break;
            }
          }
        }
        return APIResponse<List<BusSeat>>(data: orderedSeatBookings);
      }
      if (response.statusCode == 400) {
        print("4");
        final error = jsonDecode(response.body);
        return APIResponse<List<BusSeat>>(
            error: true, errorMessage: error['error']);
      }
      print("5");
      return APIResponse<List<BusSeat>>(
          error: true, errorMessage: 'An error occured 1');
    }).catchError((error) => APIResponse<List<BusSeat>>(
            error: true, errorMessage: 'An error occured 2'));
  }

  Future<APIResponse<String>> bookSeats(
    String uid, 
    String token, 
    String tripId, 
    String startingDestination, 
    String endingDestination,
    List<int> selectedSeatNumbers,
    String payerID,
    String paymentID,
  ) async {
    // sign in the passenger when the email and password is given
    String url = Constants.SERVER;
    return http.post(
      '$url/bookseats/$uid',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'seatIdArray': selectedSeatNumbers,
	      'turnId': tripId, 
	      'startStation': startingDestination, 
	      'endStation': endingDestination,
	      'paymentId': paymentID,
	      'payerId': payerID
      })
    ).then ((response) {
        print ('status code' + response.statusCode.toString());
        if(response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          return APIResponse<String>(data: data['message']); 
        }
        if(response.statusCode == 400) {
          final error = jsonDecode(response.body);
          return APIResponse<String>(error: true, errorMessage: error['error']);
        }
        return APIResponse<String>(error: true, errorMessage: 'An error occured');
      }).
      catchError((error) => APIResponse<String> (error: true, errorMessage: 'An error occured')); 
  }

  Future<APIResponse<double>> convertLKRtoUSD() async {
  // get the current and upcoming active turns assigned to the conductor
  String url = "https://free.currconv.com/api/v7/convert?q=LKR_USD&compact=ultra&apiKey=737ec7e1568aac2e1bd5";
    return http.get('$url')
      .then ((response) {
        print ('heloo');
        if(response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          return APIResponse<double>(data: data['LKR_USD']);
        } 
        return APIResponse<double>(error: true, errorMessage: 'An error occured');
      }).
      catchError((error) {
        return APIResponse<double>(error: true, errorMessage: 'An error occured');
      });
  }


Future<APIResponse<List<BusBookingData>>> getActiveBookings(String uid, String loginToken) async {
    // get the current and upcoming active turns assigned to the conductor
    String url = Constants.SERVER;
    String token = loginToken;
    List<BusBookingData> activeBookings = [];
    return http.get(
      '$url/getactivebookings/$uid',

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).then ((response) {
      if(response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        for(var i=0; i<data["turns"].length;i++){
          activeBookings.add(BusBookingData.fromJson(data["turns"][i]));
        }
        return APIResponse<List<BusBookingData>>(data: activeBookings);
      } 
      if(response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<BusBookingData>>(error: true, errorMessage: error['error']);
      }
      return APIResponse<List<BusBookingData>>(error: true, errorMessage: 'An error occured');
    }).
    catchError((error) {
      return APIResponse<List<BusBookingData>>(error: true, errorMessage: 'An error occured');
    });
  }

  Future<APIResponse<List<BusBookingData>>> getPastBookings(String uid, String loginToken) async {
    // get the current and upcoming active turns assigned to the conductor
    String url = Constants.SERVER;
    String token = loginToken;
    List<BusBookingData> activeBookings = [];
    return http.get(
      '$url/getpastbookings/$uid',

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).then ((response) {
      if(response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        for(var i=0; i<data["turns"].length;i++){
          activeBookings.add(BusBookingData.fromJson(data["turns"][i]));
        }
        return APIResponse<List<BusBookingData>>(data: activeBookings);
      } 
      if(response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<BusBookingData>>(error: true, errorMessage: error['error']);
      }
      return APIResponse<List<BusBookingData>>(error: true, errorMessage: 'An error occured');
    }).
    catchError((error) {
      return APIResponse<List<BusBookingData>>(error: true, errorMessage: 'An error occured');
    });
  }
  
}