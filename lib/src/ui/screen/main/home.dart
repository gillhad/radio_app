import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/src/config/app_colors.dart';
import 'package:radio_app/src/config/app_style.dart';
import 'package:radio_app/src/config/navigation/nav_routes.dart';
import 'package:radio_app/src/config/raw_data.dart';
import 'package:radio_app/src/model/RadioModel.dart';
import 'package:radio_app/src/provider/radio_provider.dart';
import 'package:radio_app/src/ui/widgets/station_widget.dart';

class RadioStations extends StatefulWidget {
  const RadioStations({super.key});

  @override
  State<RadioStations> createState() => _RadioStationsState();
}

class _RadioStationsState extends State<RadioStations> {
  int currentStation = 0;

  List<String> currentLanguages = [];
  List<String> tagOptions = [];
  List<String> currentTagoptions = [];
  List<RadioModel> listStations = [];
  List<String> filterSelected = [];

  bool filterExpanded = false;
  bool loadingInfo = true;

  late RadioProvider _notifier;

  @override
  void initState() {
    _notifier = Provider.of<RadioProvider>(context, listen: false);
    listStations = _notifier.stations;
    tagOptions = tags;
    // loadLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _notifier.addListener(() {
      if (_notifier.loadingInfo) {
        loadingInfo = false;
        print("laoding info es $loadingInfo");
      }
      if (listStations.isEmpty) {
        listStations = _notifier.stations;
      }
      if (_notifier.commonTags.isNotEmpty) {
        tagOptions = _notifier.commonTags;
      }
      setState(() {});
    });
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar() {
    return AppBar();
  }

  Widget _content() {
    if (loadingInfo) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 60,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Text(
                AL.of(context).home_title_loading,
                style: AppStyle.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ));
    }

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              _title(),
              _selector(),
              Spacer(),
              _showList(),
              Spacer(),
              _goButton()
            ],
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            AL.of(context).home_title,
            style: AppStyle.textTheme.titleLarge,
          ),
          Text(
            AL.of(context).home_stations_subtitle,
            style: AppStyle.textTheme.bodyMedium!.copyWith(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _selector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: _expandFilter,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        AL.of(context).home_filter,
                        style: AppStyle.textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Icon(filterExpanded ? Icons.remove : Icons.add)
                    ],
                  ),
                ),
              ),
            ),
            if (filterExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    for (var tag in tagOptions) chipFilter(tag),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _showList() {
    print(listStations.length);
    if (listStations.isEmpty) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Text(
            AL.of(context).home_title_loading_filter,
            style: AppStyle.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return Column(children: [
      Row(
        children: [
          Expanded(flex: 1, child: _arrow(Icons.chevron_left)),
          Expanded(
              flex: 5,
              child: SizedBox(
                  child: StationWidget(
                station: listStations[currentStation],
              ))),
          Expanded(flex: 1, child: _arrow(Icons.chevron_right)),
        ],
      ),
    ]);
  }

  Widget _goButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: ElevatedButton(
              onPressed: () {
                _navigation();
              },
              child: Text(
                AL.of(context).home_go,
                style: AppStyle.textTheme.bodyMedium,
              ))),
    );
  }

  Widget _arrow(IconData icon) {
    return GestureDetector(
      onTap: () {
        if (icon == Icons.chevron_left) {
          if (currentStation > 0) {
            currentStation--;
          }
        } else {
          if (currentStation < listStations.length - 1) {
            currentStation++;
          }
        }
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Icon(icon),
      ),
    );
  }

  Widget chipFilter(filter) {
    return GestureDetector(
      onTap: () {
        _onTapTag(filter);
      },
      child: FittedBox(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: filterSelected.contains(filter)
                    ? AppColors.primary
                    : Colors.grey),
            child: Text(filter)),
      ),
    );
  }

//FUNCTIONS
  _onTapTag(filter) {
    if (filterSelected.contains(filter)) {
      filterSelected.remove(filter);
    } else {
      filterSelected.add(filter);
    }
    setState(() {
      _filterList();
    });
  }

  _expandFilter() {
    setState(() {
      filterExpanded = !filterExpanded;
    });
  }

  _filterList() {
    if (filterSelected.isEmpty) {
      listStations = _notifier.stations;
    } else {
      listStations = _notifier.getRadioByFilter(filterSelected);
    }
    currentStation = 0;
    setState(() {});
  }

  _navigation() {
    _notifier.updateCurrentStation();
    Navigator.pushNamed(context, NavigatorRoutes.radio);
  }
}
