import 'package:flutter/material.dart';
import 'package:radio_app/src/config/assets.dart';
import 'package:radio_app/src/model/RadioModel.dart';

class StationWidget extends StatefulWidget {
  final RadioModel station;
  const StationWidget({required this.station,super.key});

  @override
  State<StationWidget> createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget> with TickerProviderStateMixin{
late final AnimationController _controller;
late Animation animationSmall;
late Animation animationLarge;
bool _isSmall = false;


@override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animationSmall = Tween<double>(begin: 1, end: 0).animate(_controller)..addListener(() async{setState(() {
     print("la animación hace algo");
      if(_controller.isCompleted && !_isSmall){
        setState(() {
        print(_controller.value);  
        });
        _controller.reverse();
        _isSmall = true;
      }
    });});  
  
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StationWidget oldWidget) {
    if(oldWidget.station.id!=widget.station.id){
      print("iniciamos la animación");
      print(_controller.isCompleted);
      _controller.reset();
      _controller.forward();
      print(_controller.isCompleted);
      _isSmall = false;
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    print(_controller.value);
    return StatefulBuilder(
      builder: (context, snapshot) {
    
        return Container(
          alignment: Alignment.center,
          width:MediaQuery.of(context).size.width*0.7, height: MediaQuery.of(context).size.width*0.7,child:
        
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            // curve: Curves.bounceOut,
            // duration: Duration(milliseconds: 100),
            height: (MediaQuery.of(context).size.width*0.7)*(1-_controller.value),
            width: (MediaQuery.of(context).size.width*0.7)*(1-_controller.value),
          color: Colors.grey.withOpacity(0.5),
            // child: Image(image: AssetImage(AppAssets.defaultRadio),)
            child: widget.station.avatar!=null ? Image(image: NetworkImage(widget.station.avatar!)) :  Container(),
          ),
        ));
      }
    );
  }
}