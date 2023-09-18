import 'package:flutter/material.dart';
import 'package:radio_app/src/config/assets.dart';
import 'package:radio_app/src/model/RadioModel.dart';

class StationWidget extends StatefulWidget {
  final RadioModel station;
  const StationWidget({required this.station, super.key});

  @override
  State<StationWidget> createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation animationSmall;
  late Animation animationLarge;
  bool _isSmall = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animationSmall = Tween<double>(begin: 1, end: 0).animate(_controller)
      ..addListener(() async {
        setState(() {
          if (_controller.isCompleted && !_isSmall) {
            setState(() {
              print(_controller.value);
            });
            _controller.reverse();
            _isSmall = true;
          }
        });
      });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StationWidget oldWidget) {
    if (oldWidget.station.id != widget.station.id) {
      _controller.reset();
      _controller.forward();
      _isSmall = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatefulBuilder(builder: (context, snapshot) {
          return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: (MediaQuery.of(context).size.width * 0.7) *
                      (1 - _controller.value),
                  width: (MediaQuery.of(context).size.width * 0.7) *
                      (1 - _controller.value),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      image: widget.station.avatar != ""
                          ? DecorationImage(
                              image: NetworkImage(widget.station.avatar!),
                              fit: BoxFit.cover)
                          : const DecorationImage(
                              image: AssetImage(AppAssets.defaultRadio),
                              fit: BoxFit.cover)),
                ),
              ));
        }),
        SizedBox(
          height: 30,
        ),
        Text(widget.station.name != "" ? widget.station.name : "")
      ],
    );
  }
}
