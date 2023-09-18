import 'package:dio/dio.dart';

class ApiClient{

final dio = Dio(BaseOptions(
  baseUrl: "https://de1.api.radio-browser.info/json/stations",
  connectTimeout: Duration(seconds: 5),
  receiveTimeout: Duration(seconds: 3)
));





Future getRadioStations(String country, {int? limit}) async{
    Map<String,dynamic> params = {
      "country":country,
      "order":"votes",
      "limit": limit ?? 1000,
      "reverse":"true"
    };
    var response = await requestGet("/search",params: params);

    return response;
}



Future requestGet(String path,{Map<String,dynamic>? params})async {
  print("inicia la request");
  try{
    var response = await dio.get(
      path?? "",
      queryParameters: params,
      options: Options(
      responseType: ResponseType.json,
      )
      );

    print(response);
    print(response.runtimeType);
    return response.data;
  }catch(e){
    print(e);
  }
}




}

//Conseguir los tags https://de1.api.radio-browser.info/json/stations/search?country=Spain&tags=[rock]
///BUscar por pais https://de1.api.radio-browser.info/json/stations/bycountry/spain?offset=0&limit=2