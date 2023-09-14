import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:radio_app/src/config/app_colors.dart';
import 'package:radio_app/src/config/app_style.dart';
import 'package:radio_app/src/model/RadioModel.dart';
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
  List<int> currentTagoptions = [];
  List<RadioModel> listStations = [];
  List<int> filterSelected = [];

  late RadioModel model;
  late RadioModel model2;

  bool filterExpanded = false;

  @override
  void initState() {
    model = RadioModel.fromJson(exampleRadio);
    model2 = RadioModel.fromJson(exampleRadio2);
    listStations.add(model);
    listStations.add(model2);
    // loadLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar() {
    return AppBar();
  }

  Widget _content() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
         child: Column(
        children: [_title(), _selector(),Spacer(), _showList(), Spacer(),_goButton()],
      ),
        )
      ],
      
    );
  }

  Widget _title() {
    return Text(AL.of(context).home_title, style: AppStyle.textTheme.titleLarge,);
  }

  Widget _selector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: GestureDetector(
              onTap: _expandFilter,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text(AL.of(context).home_filter, style: AppStyle.textTheme.bodyMedium,),
                    Spacer(),
                    Icon(filterExpanded ? Icons.remove : Icons.add)
                  ],
                ),
              ),
            ),
          ),
          if(filterExpanded) Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                chipFilter(1),
                chipFilter(1),
                chipFilter(1),
                chipFilter(1),
                chipFilter(1),
                chipFilter(1),
                chipFilter(2),
                chipFilter(3),
                chipFilter(4),
                chipFilter(5),
          
          
              ],
            ),
          )
        ],
      ),
    );
    
  }

  Widget _showList() {
    return Row(
      children: [
        Expanded(flex: 1,child: _arrow(Icons.chevron_left)),
        Expanded(flex: 5,child: SizedBox(child: StationWidget(station: listStations[currentStation],))),
        Expanded(flex: 1,child: _arrow(Icons.chevron_right)),
      ],
    );
  }

  Widget _goButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: ElevatedButton(onPressed: () {print("tap button");}, child: Text(AL.of(context).home_statios)),
    );
  }

  Widget _arrow(IconData icon) {
    return GestureDetector(
      onTap: () {
        print("tap");
        if (icon == Icons.chevron_left) {
          if (currentStation != 0) {
            currentStation--;
          }
        } else {
          if (currentStation < listStations.length-1) {
            currentStation++;
          }
        }
        setState(() {
          
        });
        print(currentStation);
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Icon(icon),
      ),
    );
  }

  Widget chipFilter(filter){
    return GestureDetector(
      onTap: (){
        if(filterSelected.contains(filter)){
          filterSelected.remove(filter);
        }else{
          filterSelected.add(filter);
        }
        setState(() {
          
        });
      },
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: filterSelected.contains(filter) ? AppColors.primary : Colors.grey
          ),
        child: Text("label")),
      ),
    );
  }

//FUNCTIONS

  _updateTags(index) {
    if (!currentTagoptions.contains(index)) {
      currentTagoptions.add(index);
    } else {
      currentTagoptions.remove(index);
    }
  }

  _expandFilter(){
    setState(() {
      filterExpanded = !filterExpanded;
    });

}
}
