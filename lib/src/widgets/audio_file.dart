import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;

  const AudioFile(
      {Key? key, required this.advancedPlayer, required this.audioPath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioFileState();
  }
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  // String path = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    super.initState();

    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    widget.advancedPlayer.onAudioPositionChanged.listen((d) {
      setState(() {
        _position = d;
      });
    });

    widget.advancedPlayer.setUrl(widget.audioPath);
    widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);

        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Colors.blue,
            )
          : Icon(
              _icons[1],
              size: 50,
              color: Colors.blue,
            ),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(widget.audioPath);

          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();

          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: const Icon(
        Icons.fast_forward,
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: const Icon(
        Icons.fast_rewind,
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: const Icon(
        Icons.repeat,
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);
      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(
        Icons.loop,
        size: 20,
        color: isRepeat == true ? Colors.blue : Colors.black,
      ),
      onPressed: () {
        if (isRepeat == false) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
          });
        } else if (isRepeat == true) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat = false;
          });
        }
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            // value=value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split('.')[0],
                    style: const TextStyle(fontSize: 16)),
                Text(_duration.toString().split('.')[0],
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
