import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ngvp_music/musics.dart';
import 'package:ngvp_music/player.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List musics;
  @override
  initState() {
    musics = getList();
    super.initState();
  }

  List getList() {
    return [
      Musics(
          title: "Soch na sake (Airlift 2016)",
          image:
              "https://m.media-amazon.com/images/M/MV5BMGE1ZTkyOTMtMTdiZS00YzI2LTlmYWQtOTE5YWY0NWVlNjlmXkEyXkFqcGdeQXVyNjQ3ODkxMjE@._V1_.jpg",
          singer: "Arijit Singh",
          audio:
              "https://pwdown.com/113386/05.%20Soch%20Na%20Sake%20(Version%202)%20-%20Arijit%20Singh.mp3"),
      Musics(
          title: "Bhool Bhulaiyaa 2 - Title Track",
          image:
              "https://m.media-amazon.com/images/M/MV5BYjczMWFhMjUtMzM2YS00MzgxLTk2NzktOTI0OWI4NzQ5N2RlXkEyXkFqcGdeQXVyOTAzMTc2MjA@._V1_.jpg",
          singer: "Neeraj Shridhar, Mellow D",
          audio:
              "https://pwdown.com/113638/Bhool%20Bhulaiyaa%202%20-%20Title%20Track.mp3"),
      Musics(
          title: "Kashmir Main Tu Kanyakumari",
          image:
              "https://m.media-amazon.com/images/M/MV5BMGI2ZDQ2MzgtNjk2Ny00MTU5LWE0ZWQtM2I5NjRlODY5MGM1XkEyXkFqcGdeQXVyMTA4NjE0NjEy._V1_.jpg",
          singer: "Arijit , Neeti , Sunidhi",
          audio:
              "https://pwdown.com/110624/04.%20Kashmir%20Main%20Tu%20Kanyakumari.mp3"),
      Musics(
          title: "Gerua (Dilwale 2015)",
          image:
              "https://2.bp.blogspot.com/-TvSAOzhxpV0/WQUfbvUIZDI/AAAAAAAARtQ/QlNv4m3vP9EqbafqVckAbgKaE6eXsqJ1gCLcB/s1600/gerua-dilwale.jpg",
          singer: "Arijit Singh, Antra Mitra",
          audio:
              "https://pwdown.com/113373/01.%20Gerua%20-%20Arijit%20Singh,%20Antra%20Mitra.mp3"),
      Musics(
          title: "Mohabbat Ne Mohabbat Ko",
          image:
              "https://upload.wikimedia.org/wikipedia/en/8/84/Ek_Rishtaa_poster.jpg",
          singer: "Alka Yagnik and Udit Narayan",
          audio:
              "https://pwdown.com/111007/02.%20Mohabbat%20Ne%20Mohabbat%20Ko.mp3"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "NGVP Music",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Stack(
          children: [
            Container(
              color: Color.fromARGB(255, 11, 61, 27),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: musics.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Player(music: musics[index])));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                height: 60.0,
                                width: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    musics[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(musics[index].title,
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  SizedBox(height: 5.0),
                                  Text(musics[index].singer,
                                      style: const TextStyle(
                                          fontSize: 18.0, color: Colors.white)),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.play_circle_fill,
                                color: Color.fromARGB(234, 255, 77, 33),
                                size: 45.0,
                              )
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
