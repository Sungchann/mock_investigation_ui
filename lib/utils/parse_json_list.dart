
// Parameter [json] - takes list of json 
// Parameter [Class factory.fromJson takes the data]

List<T> parseJsonList<T>(
  List<dynamic> jsonList, 
  T Function(Map<String, dynamic>) fromJson
  ){
    return jsonList.map((item) => fromJson(item as Map<String, dynamic>)).toList();
}