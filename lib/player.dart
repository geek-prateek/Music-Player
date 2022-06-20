import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ngvp_music/musics.dart';

class Player extends StatefulWidget {
  const Player({Key? key, required this.music}) : super(key: key);

  final Musics music;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  var defdur = Duration(milliseconds: 0);
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((audioState) {
      setState(() {
        isPlaying = audioState == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((audioDuration) {
      setState(() {
        duration = audioDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((audioPosition) {
      setState(() {
        position = audioPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.music.title),
        backgroundColor: Color.fromARGB(255, 176, 39, 123),
      ),
      body: Stack(children: [
        Container(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              children: [
                Container(
                  height: 260.0,
                  width: 260.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.music.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Slider(
                    value: duration != null
                        ? duration > defdur
                            ? position?.inMilliseconds?.toDouble() ?? 0.0
                            : 0.0
                        : 0.0,
                    onChanged: (double value) async {
                      position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                    },
                    min: 0.0,
                    max: duration != null
                        ? duration > defdur
                            ? duration.inMilliseconds.toDouble()
                            : 0.0
                        : 0.0),
                // Slider(
                //     min: 0.0,
                //     max: duration.inSeconds.toDouble(),
                //     value: position.inSeconds.toDouble(),
                //     onChanged: (double value) async {
                //       position = Duration(seconds: value.toInt());
                //       await audioPlayer.seek(position);
                //     }),
                SizedBox(height: 10.0),
                Text(widget.music.title,
                    style: TextStyle(fontSize: 30.0, color: Colors.white)),
                SizedBox(height: 10.0),
                Text(widget.music.singer,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                SizedBox(height: 20.0),
                IconButton(
                  color: Color.fromARGB(206, 255, 0, 0),
                  onPressed: () async {
                    if (isPlaying == true) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.play(widget.music.audio);
                    }
                  },
                  icon:
                      Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                  iconSize: 70,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
