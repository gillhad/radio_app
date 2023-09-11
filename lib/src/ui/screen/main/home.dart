import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RadioStations extends StatefulWidget {
  const RadioStations({super.key});

  @override
  State<RadioStations> createState() => _RadioStationsState();
}

class _RadioStationsState extends State<RadioStations> {
List<String> currentLanguages= [];
  
  @override
  void initState() {
    loadLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar(){
return AppBar();
  }

  Widget _content(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _title(),
          _selector(),
          _showList(),
          _goButton()
        ],
      ),
    );
  }

  Widget _title(){
    return Text("title");
  }
  Widget _selector(){
    return Form(
      child: Column(
        
      ),
    );
  }
  Widget _showList(){
    return Container(child: Text("mensaje a mostrar"),);
  }
  Widget _goButton(){
    return ElevatedButton(onPressed: (){}, child: Text("Ir a las estaciones"));
  }


//FUNCTIONS
loadLanguages(){
currentLanguages.add(AL.of(context).language_option_1);
currentLanguages.add(AL.of(context).language_option_2);
setState(() {
  
});
}
}