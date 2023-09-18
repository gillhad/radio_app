import 'dart:async';
import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/src/config/app_colors.dart';
import 'package:radio_app/src/config/app_style.dart';
import 'package:radio_app/src/config/assets.dart';
import 'package:radio_app/src/model/RadioModel.dart';
import 'package:radio_app/src/provider/radio_provider.dart';
import 'package:radio_app/src/ui/screen/main/home.dart';
import 'package:radio_player/radio_player.dart';

class PlayRadio extends StatefulWidget {
  const PlayRadio({super.key});

  @override
  State<PlayRadio> createState() => _PlayRadioState();
}

class _PlayRadioState extends State<PlayRadio> {
  final player = RadioPlayer();
  final radio = StreamSubscription;
  late RadioProvider _notifier;
  late RadioModel currentRadio;

  bool _isPlaying = false;

  @override
  void initState() {
    _notifier = Provider.of<RadioProvider>(context, listen: false);
    currentRadio = _notifier.radioOn;
    _notifier.addListener(() {
      currentRadio = _notifier.radioOn;
      if (mounted) {
        setState(() {
          player.setChannel(title: currentRadio.name, url: currentRadio.url);
        });
      }
    });
    player.setChannel(title: currentRadio.name, url: currentRadio.url);
    player.stateStream.listen((value) {
      setState(() {});
    });

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
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            stopAudio();
            Navigator.pop(context);
          }),
      title: Text(
        AL.of(context).play_radio_title,
        style: AppStyle.textTheme.titleLarge!
            .copyWith(color: AppColors.onBackground),
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          radioImage(),
          const SizedBox(
            height: 50,
          ),
          playButton(),
          randomRadio()
        ],
      ),
    );
  }

  Widget radioImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          currentRadio.name,
          style: AppStyle.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              image: currentRadio.avatar != ""
                  ? DecorationImage(
                      image: NetworkImage(currentRadio.avatar!),
                      fit: BoxFit.cover)
                  : const DecorationImage(
                      image: AssetImage(AppAssets.defaultRadio),
                      fit: BoxFit.cover)),
        ),
      ],
    );
  }

  Widget playButton() {
    return GestureDetector(
      onTap: () {
        _isPlaying ? stopAudio() : playAudio();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryContainer),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          size: 80,
        ),
      ),
    );
  }

  Widget randomRadio() {
    return GestureDetector(
      onTap: () {
        _notifier.getRandomStation();
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  AL.of(context).play_random,
                  style: AppStyle.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              flex: 1,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primaryContainer),
                child: Icon(
                  Icons.loop,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///Functions

  playAudio() {
    player.play();
    setState(() {
      _isPlaying = true;
    });
  }

  stopAudio() {
    player.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  getRandom() {}
}
