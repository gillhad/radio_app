import 'package:dio/dio.dart';

class ApiClient{

final options = BaseOptions(
  baseUrl: "http://de1.api.radio-browser.info/json/stations",
  connectTimeout: Duration(seconds: 5),
  receiveTimeout: Duration(seconds: 3)
);

final dio = Dio();



Future getRadioStations(String country,List<String>? tags) async{
    Map<String,dynamic> params = {
      "country":country,
      "order":"votes",
    };
    params.putIfAbsent("tags", () => tags);
    var response = await requestGet("/search", tags);
}



requestGet(String path, params){
    var response = dio.get(path, queryParameters: params);

    print(response);
    return response;
}




}

//Conseguir los tags https://de1.api.radio-browser.info/json/stations/search?country=Spain&tags=[rock]
///BUscar por pais https://de1.api.radio-browser.info/json/stations/bycountry/spain?offset=0&limit=2