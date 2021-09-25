import 'dart:convert';

import 'package:audio_player/src/widgets/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/src/utils/app_colors.dart' as AppColors;
import 'package:flutter/rendering.dart';

class DetailAudio extends StatefulWidget {
  final booksData;
  final int index;

  const DetailAudio({Key? key, this.booksData, required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailAudioState();
  }
}

class _DetailAudioState extends State<DetailAudio> {
  late AudioPlayer advancedPlayer;
  late List fav_books = [];

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
    readData();
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.dispose();
  }

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((value) {
      setState(() {
        fav_books = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: AppColors.audioBlueBackground,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * .2,
            height: screenHeight * .36,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    widget.booksData[widget.index]['title'],
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"),
                  ),
                  Text(
                    widget.booksData[widget.index]['text'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  AudioFile(
                      advancedPlayer: advancedPlayer,
                      audioPath: widget.booksData[widget.index]['audio']),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.audioGreyBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(
                          image:
                              AssetImage(widget.booksData[widget.index]['img']),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * .58,
            left: 15,
            child: const Text(
              "Add To Playlist",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: screenHeight * .65,
            left:10 ,
            right: 10,
            bottom: screenHeight * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: fav_books.length,
                itemBuilder: (_, index) {
                  return Container(
                    width: screenWidth*.26,
                    margin: const EdgeInsets.only(right: 10,left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          fav_books[index]["img"],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            bottom: screenHeight * 0.02,
            left: 25,
            right: 25,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline_sharp)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.star_border)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
