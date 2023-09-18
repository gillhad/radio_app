import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/src/api/api_client.dart';
import 'package:radio_app/src/model/RadioModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;

class RadioProvider with ChangeNotifier {
  List<RadioModel> stations = [];
  List<String> commonTags = [];
  int currentStation = 0;
  late RadioModel radioOn;
  bool loadingInfo = true;

//Actualiza la station actual
  updateCurrentStation() {
    radioOn = stations.elementAt(currentStation);
    notifyListeners();
  }

//Devuelve una radio random
  getRandomStation() {
    currentStation = math.Random().nextInt(stations.length);
    updateCurrentStation();
    notifyListeners();
  }

//Petición a la API de radios
  getRadios(context) async {
    var response = await ApiClient()
        .getRadioStations(Platform.localeName.split("_")[0], limit: 1000);
    await response.forEach((radio) => stations.add(RadioModel.fromJson(radio)));
    await getCommonTags();
    loadingInfo = false;
    notifyListeners();
  }

  ///Obtiene los tags mas comunes de las radios obtenidas en la request
  Future getCommonTags() async {
    Map<String, int> countTags = {};
    for (var station in stations) {
      if (station.tags.isNotEmpty) {
        for (var tag in station.tags) {
          await countTags.update(tag, (value) {
            return _addValue(value);
          }, ifAbsent: () => 1);
        }
        ;
      }
      ;
    }

    Map<int, dynamic> newMap = {};
    countTags.forEach((key, value) => newMap.putIfAbsent(value, () => key));
    var sortedByKeyMap = Map.fromEntries(
        newMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    newMap.forEach((key, value) {
      if (key > 10) {
        commonTags.add(value);
      }
    });
    Future.delayed(Duration(milliseconds: 500));
    notifyListeners();
  }

//Cuenta las cadenas con el mismo tag
  _addValue(value) {
    int newValue = value + 1;
    return newValue;
  }

//Filtra las radios por tags
  List<RadioModel> getRadioByFilter(filters) {
    List<RadioModel> newList = [];
    stations.forEach((station) {
      bool hasAllFilters = true;
      for (var filter in filters) {
        if (!station.tags.contains(filter)) {
          hasAllFilters = false;
        }
      }
      if (hasAllFilters) {
        newList.add(station);
      } else {}
    });
    return newList;
  }
}
