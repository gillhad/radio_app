class RadioModel{
  late String id;
  late String name;
  late String url;
  String? avatar;
  late List<String> tags = [];


RadioModel.fromJson(json){
  id = json["stationuuid"];
  name = json["name"];
  url = json["url_resolved"];
  avatar = json["favicon"];
  if(json["tags"].isNotEmpty){
  tags = json["tags"].split(",");
  }
}

}

Map<String,dynamic> exampleRadio = 
  {"changeuuid":"75a74db7-691b-4fe0-baf3-8e7429ab4f2e","stationuuid":"729dd686-b23d-446f-8d43-b22ad57d5512","serveruuid":"21936d66-d09a-4f4f-b7db-2176e8a0728a","name":"Flow Radio","url":"http://37.187.76.127:8010/flow","url_resolved":"http://37.187.76.127:8010/flow","homepage":"https://www.flowradio.es/","favicon":"https://flowradio.es/wp-content/uploads/2018/02/logo_flowradio_web.png","tags":"r&b/urban","country":"Spain","countrycode":"ES","iso_3166_2":null,"state":"","language":"","languagecodes":"","votes":0,"lastchangetime":"2023-08-29 08:45:10","lastchangetime_iso8601":"2023-08-29T08:45:10Z","codec":"MP3","bitrate":192,"hls":0,"lastcheckok":1,"lastchecktime":"2023-09-11 09:13:23","lastchecktime_iso8601":"2023-09-11T09:13:23Z","lastcheckoktime":"2023-09-11 09:13:23","lastcheckoktime_iso8601":"2023-09-11T09:13:23Z","lastlocalchecktime":"2023-09-11 02:14:57","lastlocalchecktime_iso8601":"2023-09-11T02:14:57Z","clicktimestamp":"2023-09-07 05:03:48","clicktimestamp_iso8601":"2023-09-07T05:03:48Z","clickcount":3,"clicktrend":0,"ssl_error":0,"geo_lat":null,"geo_long":null,"has_extended_info":false};

  Map<String,dynamic> exampleRadio2 = {"changeuuid":"1577fcc9-2f35-423a-8d4a-e4ec39cf4700","stationuuid":"960c37c6-0601-11e8-ae97-52543be04c81","serveruuid":"3ae47dc4-6469-44c7-895f-49e205d8c61d","name":"Cadena 100","url":"http://cadena100-streamers-mp3.flumotion.com/cope/cadena100.mp3","url_resolved":"http://cadena100-streamers-mp3.flumotion.com/cope/cadena100.mp3","homepage":"http://www.cadena100.es/","favicon":"https://d1v6pqrrmmnutj.cloudfront.net/post_square_images/attachments/000/000/821/original/cadena100.png?2015","tags":"music","country":"Spain","countrycode":"ES","iso_3166_2":null,"state":"","language":"spanish","languagecodes":"es","votes":17685,"lastchangetime":"2023-07-30 20:21:14","lastchangetime_iso8601":"2023-07-30T20:21:14Z","codec":"MP3","bitrate":128,"hls":0,"lastcheckok":1,"lastchecktime":"2023-09-11 17:24:52","lastchecktime_iso8601":"2023-09-11T17:24:52Z","lastcheckoktime":"2023-09-11 17:24:52","lastcheckoktime_iso8601":"2023-09-11T17:24:52Z","lastlocalchecktime":"2023-09-10 23:28:01","lastlocalchecktime_iso8601":"2023-09-10T23:28:01Z","clicktimestamp":"2023-09-11 21:08:12","clicktimestamp_iso8601":"2023-09-11T21:08:12Z","clickcount":949,"clicktrend":51,"ssl_error":0,"geo_lat":null,"geo_long":null,"has_extended_info":false};