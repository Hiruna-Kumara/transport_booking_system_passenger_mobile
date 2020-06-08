class RoutesDropdown {
  String id;
  // dynamic routeId;

  RoutesDropdown({this.id});

  factory RoutesDropdown.fromJson(Map<String,dynamic> routes)  {
    return RoutesDropdown(
      id:routes['id'],
    );
  }
}