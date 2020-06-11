import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:transport_booking_system_passenger_mobile/constants.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/userData.dart';
// import 'package:transport_booking_system_passenger_mobile/controllers/auth_controller.dart';
// import 'package:transport_booking_system_passenger_mobile/lib/models/api_response.dart';
// import 'package:transport_booking_system_passenger_mobile/lib/models/bus_seat.dart';
// import 'package:transport_booking_system_passenger_mobile/lib/models/bus_trip_data.dart';
// import 'package:transport_booking_system_passenger_mobile/lib/models/passenger.dart';
// import 'package:transport_booking_system_passenger_mobile/lib/models/user_data.dart';

class MockClient extends Mock implements http.Client {}

//unit tests using mockito
main() {
  final client = MockClient();
  String url = Constants.SERVER;
  String email = "vshkumara@gmail.com";
  String password = "12345678";
  // String uid = "JQpqbvSZUJSrH0Ffx3gn69PF4ER2";
  // String token = "cndjcndjcnjdcnjdc";
  // String tripId = "jhfjncejnc";
  // String seatId = "2";

  group('signInUser', () {
    test(
        'returns a UserData object as the data property of the APIResponse object if the http call completes successfully and the role is a passenger',
        () async {
      Map<String, dynamic> apiResponse = {
        "message": "Sign in success",
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiJZUzFNUFNTbXJiUmhCWm5sY3pmRjBCYlhsYTAyIiwiaWF0IjoxNTg1ODM5NzI2LCJleHAiOjE1ODY0NDQ1MjZ9.77BQhSH4W6I78GhlMKJiZWKoikp-ma0AWc6tkEhNJno",
        "user": {
          "user": {
            "user": {
              "uid": "YS1MPSSmrbRhBZnlczfF0BbXla02",
              "displayName": "LocalHost AppTest",
              "photoURL": null,
              "email": "kumarasinghe.k.a.s.h@gmail.com",
              "emailVerified": false,
              "phoneNumber": "+94712652733",
              "isAnonymous": false,
              "tenantId": null,
              "providerData": [
                {
                  "uid": "+94712652733",
                  "displayName": null,
                  "photoURL": null,
                  "email": null,
                  "phoneNumber": "+94712652733",
                  "providerId": "phone"
                },
                {
                  "uid": "kumarasinghe.k.a.s.h@gmail.com",
                  "displayName": "LocalHost AppTest",
                  "photoURL": null,
                  "email": "kumarasinghe.k.a.s.h@gmail.com",
                  "phoneNumber": null,
                  "providerId": "password"
                }
              ],
              "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
              "appName": "[DEFAULT]",
              "authDomain": "transport-booking-system-62ea6.firebaseapp.com",
              "stsTokenManager": {
                "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
                "refreshToken":
                    "AE0u-NeDLkNbWyPR12R4oLTtxPimApkkZTkmhqi8ThCgS3I4PHJ_hvkjmf-JTwJIT5EchVuJBUH28kxVaUsBG593cz1V16EFCF0RpezqUF1od3Uix1QUVBDJVCliKUZ5NJjOtZ3NdvBkFNvxiFvxFhKy-L5htvbr1xE0F0OlfOY5jIF9veUCa_TVuuryaE2XobhszR5ZijLrEf0VQj-u0tC0PS5otwBMPT01xG0PVtws3-Uv2u_KZgnNZ7z-z_68TxbRZPznXomdPM2HSlTk1bPO_JgabMJFqJgSIYk07_pIcfR7IBYaTU0",
                "accessToken":
                    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjgzYTczOGUyMWI5MWNlMjRmNDM0ODBmZTZmZWU0MjU4Yzg0ZGI0YzUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTG9jYWxIb3N0IEFwcFRlc3QiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhbnNwb3J0LWJvb2tpbmctc3lzdGVtLTYyZWE2IiwiYXVkIjoidHJhbnNwb3J0LWJvb2tpbmctc3lzdGVtLTYyZWE2IiwiYXV0aF90aW1lIjoxNTg1ODM5NzIwLCJ1c2VyX2lkIjoiWVMxTVBTU21yYlJoQlpubGN6ZkYwQmJYbGEwMiIsInN1YiI6IllTMU1QU1NtcmJSaEJabmxjemZGMEJiWGxhMDIiLCJpYXQiOjE1ODU4Mzk3MjAsImV4cCI6MTU4NTg0MzMyMCwiZW1haWwiOiJrdW1hcmFzaW5naGUuay5hLnMuaEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlciI6Iis5NDcxMjY1MjczMyIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzk0NzEyNjUyNzMzIl0sImVtYWlsIjpbImt1bWFyYXNpbmdoZS5rLmEucy5oQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.fj1cKrOIiX_K6FoQSTimNP4_rBEccjt5naWAr1e7J7v6pjjsvzP_PJtDNcK6JmpqbeWUHKlRa2JnNISIS8ee0PLOlttKb0prTx9guX0zHVhxo08dBA5FZ9pBwY_Lsh68VFOMUPXUcr1rpVpiw4iP-w_xhPKatsAfSKXEPooiNeMxRYrS0E53nQvMxDeLITGbsWCVz5_Ut0nq2DSIWPnzv2dHIGc4AYIOFTX4tUeKJrpQmBJ55jHZr9NAM6AuFOgxD_Am2qq3HQ1vrOmDeDTxuZ8bhrs7zZa0deK7g-kXrCgtFIVYvWG8parmth4FNZF18YhuRpveWCb3r57Kxt5Q7w",
                "expirationTime": 1585843320612
              },
              "redirectEventId": null,
              "lastLoginAt": "1585839720515",
              "createdAt": "1584621374297"
            },
            "credential": null,
            "additionalUserInfo": {
              "providerId": "password",
              "isNewUser": false
            },
            "operationType": "signIn"
          },
          "role": "PASSENGER",
          "phone_verified": false
        }
      };

      String jsonString = jsonEncode(apiResponse);
      final AuthController _auth = AuthController();

      when(client.post('$url/signin',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(
                  <String, String>{'email': email, 'password': password})))
          .thenAnswer((_) async => http.Response(jsonString, 200));

      APIResponse<UserData> response =
          await _auth.signInPassenger(client, email, password);
      expect(response.data, isInstanceOf<UserData>());
      expect(response.error, false);
    });

    // test(
    //     'returns a UserData object as the data property of the APIResponse object if the http call completes successfully and the role is a passenger',
    //     () async {
    //   Map<String, dynamic> apiResponse = {
    //     "message": "Sign in success",
    //     "token":
    //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiJZUzFNUFNTbXJiUmhCWm5sY3pmRjBCYlhsYTAyIiwiaWF0IjoxNTg1ODM5NzI2LCJleHAiOjE1ODY0NDQ1MjZ9.77BQhSH4W6I78GhlMKJiZWKoikp-ma0AWc6tkEhNJno",
    //     "user": {
    //       "user": {
    //         "user": {
    //           "uid": "YS1MPSSmrbRhBZnlczfF0BbXla02",
    //           "displayName": "LocalHost AppTest",
    //           "photoURL": null,
    //           "email": "kumarasinghe.k.a.s.h@gmail.com",
    //           "emailVerified": false,
    //           "phoneNumber": "+94712652733",
    //           "isAnonymous": false,
    //           "tenantId": null,
    //           "providerData": [
    //             {
    //               "uid": "+94712652733",
    //               "displayName": null,
    //               "photoURL": null,
    //               "email": null,
    //               "phoneNumber": "+94712652733",
    //               "providerId": "phone"
    //             },
    //             {
    //               "uid": "kumarasinghe.k.a.s.h@gmail.com",
    //               "displayName": "LocalHost AppTest",
    //               "photoURL": null,
    //               "email": "kumarasinghe.k.a.s.h@gmail.com",
    //               "phoneNumber": null,
    //               "providerId": "password"
    //             }
    //           ],
    //           "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
    //           "appName": "[DEFAULT]",
    //           "authDomain": "transport-booking-system-62ea6.firebaseapp.com",
    //           "stsTokenManager": {
    //             "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
    //             "refreshToken":
    //                 "AE0u-NeDLkNbWyPR12R4oLTtxPimApkkZTkmhqi8ThCgS3I4PHJ_hvkjmf-JTwJIT5EchVuJBUH28kxVaUsBG593cz1V16EFCF0RpezqUF1od3Uix1QUVBDJVCliKUZ5NJjOtZ3NdvBkFNvxiFvxFhKy-L5htvbr1xE0F0OlfOY5jIF9veUCa_TVuuryaE2XobhszR5ZijLrEf0VQj-u0tC0PS5otwBMPT01xG0PVtws3-Uv2u_KZgnNZ7z-z_68TxbRZPznXomdPM2HSlTk1bPO_JgabMJFqJgSIYk07_pIcfR7IBYaTU0",
    //             "accessToken":
    //                 "eyJhbGciOiJSUzI1NiIsImtpZCI6IjgzYTczOGUyMWI5MWNlMjRmNDM0ODBmZTZmZWU0MjU4Yzg0ZGI0YzUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTG9jYWxIb3N0IEFwcFRlc3QiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhbnNwb3J0LWJvb2tpbmctc3lzdGVtLTYyZWE2IiwiYXVkIjoidHJhbnNwb3J0LWJvb2tpbmctc3lzdGVtLTYyZWE2IiwiYXV0aF90aW1lIjoxNTg1ODM5NzIwLCJ1c2VyX2lkIjoiWVMxTVBTU21yYlJoQlpubGN6ZkYwQmJYbGEwMiIsInN1YiI6IllTMU1QU1NtcmJSaEJabmxjemZGMEJiWGxhMDIiLCJpYXQiOjE1ODU4Mzk3MjAsImV4cCI6MTU4NTg0MzMyMCwiZW1haWwiOiJrdW1hcmFzaW5naGUuay5hLnMuaEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlciI6Iis5NDcxMjY1MjczMyIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzk0NzEyNjUyNzMzIl0sImVtYWlsIjpbImt1bWFyYXNpbmdoZS5rLmEucy5oQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.fj1cKrOIiX_K6FoQSTimNP4_rBEccjt5naWAr1e7J7v6pjjsvzP_PJtDNcK6JmpqbeWUHKlRa2JnNISIS8ee0PLOlttKb0prTx9guX0zHVhxo08dBA5FZ9pBwY_Lsh68VFOMUPXUcr1rpVpiw4iP-w_xhPKatsAfSKXEPooiNeMxRYrS0E53nQvMxDeLITGbsWCVz5_Ut0nq2DSIWPnzv2dHIGc4AYIOFTX4tUeKJrpQmBJ55jHZr9NAM6AuFOgxD_Am2qq3HQ1vrOmDeDTxuZ8bhrs7zZa0deK7g-kXrCgtFIVYvWG8parmth4FNZF18YhuRpveWCb3r57Kxt5Q7w",
    //             "expirationTime": 1585843320612
    //           },
    //           "redirectEventId": null,
    //           "lastLoginAt": "1585839720515",
    //           "createdAt": "1584621374297"
    //         },
    //         "credential": null,
    //         "additionalUserInfo": {
    //           "providerId": "password",
    //           "isNewUser": false
    //         },
    //         "operationType": "signIn"
    //       },
    //       "role": "PASSENGER",
    //       "phone_verified": false
    //     }
    //   };

    //   String jsonString = jsonEncode(apiResponse);
    //   final AuthController _auth = AuthController();

    //   when(client.post('$url/signin',
    //           headers: <String, String>{
    //             'Content-Type': 'application/json; charset=UTF-8',
    //           },
    //           body: jsonEncode(
    //               <String, String>{'email': email, 'password': password})))
    //       .thenAnswer((_) async => http.Response(jsonString, 200));

    //   APIResponse<UserData> response =
    //       await _auth.signInPassenger(client, email, password);
    //   expect(response.data, isInstanceOf<UserData>());
    //   expect(response.error, false);
    // });

    // test('returns error property as true of the APIResponse object if the http call completes successfully and the role is not a conductor', () async {

    //   Map <String, dynamic> apiResponse =
    //   {
    //     "message": "Sign in success",
    //     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiJKUXBxYnZTWlVKU3JIMEZmeDNnbjY5UEY0RVIyIiwiaWF0IjoxNTkxNzYzMDU5LCJleHAiOjE1OTIzNjc4NTl9.m7FKUrQMOkQ_oCVd9F_8E59l5PvQjZ_lbhNdx8hO-jw",
    //     "user": {
    //         "user": {
    //             "user": {
    //                 "uid": "JQpqbvSZUJSrH0Ffx3gn69PF4ER2",
    //                 "displayName": "T.L. Sumanasiri",
    //                 "photoURL": null,
    //                 "email": "conductor@domain.com",
    //                 "emailVerified": false,
    //                 "phoneNumber": "+94765944189",
    //                 "isAnonymous": false,
    //                 "tenantId": null,
    //                 "providerData": [
    //                     {
    //                         "uid": "+94765944189",
    //                         "displayName": null,
    //                         "photoURL": null,
    //                         "email": null,
    //                         "phoneNumber": "+94765944189",
    //                         "providerId": "phone"
    //                     },
    //                     {
    //                         "uid": "conductor@domain.com",
    //                         "displayName": "T.L. Sumanasiri",
    //                         "photoURL": null,
    //                         "email": "conductor@domain.com",
    //                         "phoneNumber": null,
    //                         "providerId": "password"
    //                     }
    //                 ],
    //                 "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
    //                 "appName": "[DEFAULT]",
    //                 "authDomain": "transport-booking-system-62ea6.firebaseapp.com",
    //                 "stsTokenManager": {
    //                     "apiKey": "AIzaSyC4tb450WQnjVEIDTzq1egfy4APmPICE3k",
    //                     "refreshToken": "AE0u-NfLzYC6qtnUTGVMGN-JUqXwEy0iGwZFQ-m_MPDxjFmXqAa1vZm5y1UWAfm4TxuymE5x4OJeVeiOMYh0QiwTT3QnN-o9Mci_Vrqr6YoY5tgsb7O9aBA3UJ6KjxjvMA1QIji0OpQ6TCa7fzkyXFv8sbLVMpim2tgG9lsZw2DjvMyIIfaoAuAYDmePU50HJhM_0EGL0V5PILstcKCkg-vix9V1MqKeT_XSznQCVU__bdPwRBTRGmoy2yf5Y6-bnLBJyBd9LRYjICpxerc785HCEKFDpzMRLQ",
    //                     "accessToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlMjdmNWIwNjllYWQ4ZjliZWYxZDE0Y2M2Mjc5YmRmYWYzNGM1MWIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiVC5MLiBTdW1hbmFzaXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3RyYW5zcG9ydC1ib29raW5nLXN5c3RlbS02MmVhNiIsImF1ZCI6InRyYW5zcG9ydC1ib29raW5nLXN5c3RlbS02MmVhNiIsImF1dGhfdGltZSI6MTU5MTc2MzA1OCwidXNlcl9pZCI6IkpRcHFidlNaVUpTckgwRmZ4M2duNjlQRjRFUjIiLCJzdWIiOiJKUXBxYnZTWlVKU3JIMEZmeDNnbjY5UEY0RVIyIiwiaWF0IjoxNTkxNzYzMDU4LCJleHAiOjE1OTE3NjY2NTgsImVtYWlsIjoiY29uZHVjdG9yQGRvbWFpbi5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlciI6Iis5NDc2NTk0NDE4OSIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzk0NzY1OTQ0MTg5Il0sImVtYWlsIjpbImNvbmR1Y3RvckBkb21haW4uY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.I9ylEyLJ_hQoGxfY8DgQMwx2_ca_caKM-hOWxg83h0bFIKZnphymzGl9jXdhfsWCBV4dj7WIo9lJocn5VpLFnMPkclnYbD-JGfXUdvA3w-0OdSQiLD9Pif7Hc3Jjc0i3YqZOoH6Cr1DkAd1d71_GuJBBMlKhT0FtD8EXnogKdZEGRn9ZjyE9N5e2y4dbXaIRhyoZyENC6xyrRTI429a61ujkY61R4YeNeIE-1a3ZYMKmSUa_jP2Or324diYl0W1wB16YENeMMwGB5iJptN6D8GD5Cxo4Vfa1S12M80Bz5OjTW7scWj-w0Bh1d7YXqAmGEsC2ZMgYRhh3LA6XZau6dg",
    //                     "expirationTime": 1591766658965
    //                 },
    //                 "redirectEventId": null,
    //                 "lastLoginAt": "1591763058937",
    //                 "createdAt": "1587612998186"
    //             },
    //             "credential": null,
    //             "additionalUserInfo": {
    //                 "providerId": "password",
    //                 "isNewUser": false
    //             },
    //             "operationType": "signIn"
    //         },
    //         "role": "PASSENGER",
    //         "phone_verified": true
    //     }
    //   };
    //   String jsonString = jsonEncode(apiResponse);
    //   final AuthController _auth = AuthController();

    //   when(client.post(
    //   '$url/signin',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'email': email,
    //     'password': password
    //   })
    // ))
    //   .thenAnswer((_) async => http.Response(jsonString, 200));

    //   APIResponse<UserData> response = await _auth.signInPassenger(client, email, password);
    //   expect(response.error, true);

    // });

    // test('returns error property as true of the APIResponse object if the http call completes with a status code of 400', () async {

    //   Map <String, dynamic> apiResponse = {
    //     "error": "Error signing in"
    //   };

    //   String jsonString = jsonEncode(apiResponse);
    //   final AuthController _auth = AuthController();

    //   when(client.post(
    //   '$url/signin',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'email': email,
    //     'password': password
    //   })
    // ))
    //   .thenAnswer((_) async => http.Response(jsonString, 400));

    //   APIResponse<UserData> response = await _auth.signInPassenger(client, email, password);
    //   expect(response.error, true);

    // });
  });
}

//   group('getActiveTurns', () {

//     test('returns a list of BusTripData objects as the data property of the APIResponse object if the http call completes successfully', () async {

//       Map <String, dynamic> apiResponse =
//       {
//         "turns": [
//             {
//                 "turnId": "IB5CS5JD7foW57HVUVFo 2020-05-10T07:42:05.750Z",
//                 "busNo": "LV-1873",
//                 "departureTime": "2020-05-10T07:42:05.750Z",
//                 "startStation": "Kurunegala",
//                 "arrivalTime": "2020-05-10T10:57:05.750Z",
//                 "endStation": "Colombo",
//                 "NormalSeatPrice": 159,
//                 "busType": "3x2 bus",
//                 "addedDate": {
//                     "_seconds": 1588911190,
//                     "_nanoseconds": 132000000
//                 }
//             }
//         ]
//     };
//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.get(
//       '$url/getactiveturns/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 200));

//       APIResponse<List<BusTripData>> response = await _auth.getActiveTurns(client, uid, token);
//       expect(response.data, isInstanceOf<List<BusTripData>>());
//       expect(response.error, false);

//     });

//     test('returns error property as true of the APIResponse object if the http call completes with a status code of 400', () async {

//       Map <String, dynamic> apiResponse = {
//         "error" : "Something went wrong"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.get(
//       '$url/getactiveturns/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 400));

//       APIResponse<List<BusTripData>> response = await _auth.getActiveTurns(client, uid, token);
//       expect(response.error, true);

//     });

//   });

//   group('getPastTurns', () {

//     test('returns a list of BusTripData objects as the data property of the APIResponse object if the http call completes successfully', () async {

//       Map <String, dynamic> apiResponse =
//       {
//         "turns": [
//             {
//                 "turnId": "IB5CS5JD7foW57HVUVFo 2020-05-10T07:42:05.750Z",
//                 "busNo": "LV-1873",
//                 "departureTime": "2020-05-10T07:42:05.750Z",
//                 "startStation": "Kurunegala",
//                 "arrivalTime": "2020-05-10T10:57:05.750Z",
//                 "endStation": "Colombo",
//                 "NormalSeatPrice": 159,
//                 "busType": "3x2 bus",
//                 "addedDate": {
//                     "_seconds": 1588911190,
//                     "_nanoseconds": 132000000
//                 }
//             }
//         ]
//     };
//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.get(
//       '$url/getpastturns/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 200));

//       APIResponse<List<BusTripData>> response = await _auth.getPastTurns(client, uid, token);
//       expect(response.data, isInstanceOf<List<BusTripData>>());
//       expect(response.error, false);

//     });

//     test('returns error property as true of the APIResponse object if the http call completes with a status code of 400', () async {

//       Map <String, dynamic> apiResponse = {
//         "error" : "Something went wrong"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.get(
//       '$url/getpastturns/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 400));

//       APIResponse<List<BusTripData>> response = await _auth.getPastTurns(client, uid, token);
//       expect(response.error, true);

//     });

//   });

//   group('getBookings', () {

//     test('returns a list of BusSeat objects as the data property of the APIResponse object if the http call completes successfully', () async {

//       Map <String, dynamic> apiResponse =
//       {
//       "seats": [
//           {
//               "id": "1",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210,
//               "booking": ""
//           },
//           {
//               "id": "10",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "11",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "12",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "13",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "14",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "15",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "16",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "17",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "18",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 18"
//           },
//           {
//               "id": "19",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "2",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 2"
//           },
//           {
//               "id": "20",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "21",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "22",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "23",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "24",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": ""
//           },
//           {
//               "id": "25",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "26",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "27",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "28",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "29",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "3",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 3"
//           },
//           {
//               "id": "30",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "31",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "32",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "33",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "34",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "35",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "36",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "37",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "38",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "39",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "4",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 4"
//           },
//           {
//               "id": "40",
//               "status": "Unavailable",
//               "seatType": "WINDOW",
//               "price": 210,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 40"
//           },
//           {
//               "id": "41",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "42",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "43",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "44",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "45",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "46",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "47",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "48",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "49",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "5",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "50",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "51",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "52",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "53",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           },
//           {
//               "id": "54",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "6",
//               "status": "Available",
//               "seatType": "WINDOW",
//               "price": 210
//           },
//           {
//               "id": "7",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 7"
//           },
//           {
//               "id": "8",
//               "status": "Unavailable",
//               "seatType": "NORMAL",
//               "price": 200,
//               "booking": "IB5CS5JD7foW57HVUVFo 2020-05-16T09:00:00.000Z DWdVmncG0rT5VmFEuso1GzNocZp1 8"
//           },
//           {
//               "id": "9",
//               "status": "Available",
//               "seatType": "NORMAL",
//               "price": 200
//           }
//       ]
//   };
//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.post(
//       '$url/getseatdetailsbyconductor/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'turnId': tripId,
//       })
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 200));

//       APIResponse<List<BusSeat>> response = await _auth.getBookings(client, uid, token, tripId);
//       expect(response.data, isInstanceOf<List<BusSeat>>());
//       expect(response.error, false);

//     });

//     test('returns error property as true of the APIResponse object if the http call completes with a status code of 400', () async {

//       Map <String, dynamic> apiResponse = {
//         "error" : "Something went wrong"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.post(
//       '$url/getseatdetailsbyconductor/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'turnId': tripId,
//       })
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 400));

//       APIResponse<List<BusSeat>> response = await _auth.getBookings(client, uid, token, tripId);
//       expect(response.error, true);

//     });

//   });

//   group('getPassengerDetails', () {

//     test('returns a Passenger object as the data property of the APIResponse object if the http call completes successfully and message is null', () async {

//       Map <String, dynamic> apiResponse =
//       {
//         "startStation": "Colombo",
//         "endStation": "Kurunegala",
//         "passengerName": "fghujiko dfhatyfva",
//         "passengerPhone": "+94772652713"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.post(
//       '$url/getpassengerfromseat/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'turnId': tripId,
//         'seatId': seatId
//       })
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 200));

//       APIResponse<Passenger> response = await _auth.getPassengerDetails(client, uid, token, tripId, seatId);
//       expect(response.data, isInstanceOf<Passenger>());
//       expect(response.error, false);

//     });

//     test('returns error property as true of the APIResponse object if the http call completes successfully and message is not null', () async {

//       Map <String, dynamic> apiResponse =
//       {
//         "message": "Not yet booked"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.post(
//       '$url/getpassengerfromseat/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'turnId': tripId,
//         'seatId': seatId
//       })
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 200));

//       APIResponse<Passenger> response = await _auth.getPassengerDetails(client, uid, token, tripId, seatId);
//       expect(response.error, true);

//     });
//     test('returns error property as true of the APIResponse object if the http call completes with a status code of 400', () async {

//       Map <String, dynamic> apiResponse = {
//         "error" : "Something went wrong"
//       };

//       String jsonString = jsonEncode(apiResponse);
//       final AuthController _auth = AuthController();

//       when(client.post(
//       '$url/getpassengerfromseat/$uid',

//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'turnId': tripId,
//         'seatId': seatId
//       })
//     ))
//       .thenAnswer((_) async => http.Response(jsonString, 400));

//       APIResponse<Passenger> response = await _auth.getPassengerDetails(client, uid, token, tripId, seatId);
//       expect(response.error, true);

//     });

//   });

// }
