class RouteDataGetById {
  String turnId;
  String departureTime;
  String startStation;
  String arrivalTime;
  String endStation;
  int normalSeatPrice;
  String busType;
  // dynamic routeId;

  RouteDataGetById({this.turnId, this.departureTime, this.startStation, this.arrivalTime, this.endStation, this.normalSeatPrice, this.busType});

  factory RouteDataGetById.fromJson(Map<String,dynamic> turns)  {
    return RouteDataGetById(
      // routeName: route['name'],
      // shortName: route['short_name'],
      // departureStop: route['departure_stop'],
      // arrivalStop: route['arrival_stop'], 
      // status: route['status'],
      // // routeId: route['routeId'],
      // routeId: "1 Colombo Kandy",
      turnId: turns['turnId'],
      departureTime: turns['departureTime'],
      startStation: turns['startStation'],
      arrivalTime: turns['arrivalTime'],
      endStation: turns['endStation'],
      normalSeatPrice: turns['NormalSeatPrice'],
      busType: turns['busType'],

    );
  }
}