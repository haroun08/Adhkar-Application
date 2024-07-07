import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/AdhkarItem .dart';

class Adhkar extends StatefulWidget {
  const Adhkar({Key? key}) : super(key: key);

  @override
  _AdhkarState createState() => _AdhkarState();
}

class _AdhkarState extends State<Adhkar> {
  List<AdhkarItem>? _adhkarItems; // Declare as nullable initially
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAdhkarData();
  }

  Future<void> _loadAdhkarData() async {
    final String jsonString = await rootBundle.loadString('assets/adhkar.json');
    final jsonData = jsonDecode(jsonString);
    setState(() {
      _adhkarItems = List<AdhkarItem>.from(
          jsonData.map((item) => AdhkarItem.fromJson(item)));
    });
  }

  void _playAudio(String audioFileName) async {
    final String audioPath = '$audioFileName';
    audioPath.replaceAll('//', '/');
    try {
      await _audioPlayer.setSource(AssetSource(audioPath));
      await _audioPlayer.resume();
    } catch (e) {
      print('Error loading audio file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adhkar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: _adhkarItems == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _adhkarItems!.length,
        itemBuilder: (context, index) {
          final adhkarItem = _adhkarItems![index];
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adhkarItem.category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      adhkarItem.array[0]['text'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite,
                            color: adhkarItem.isFavorite
                                ? Colors.red
                                : Colors.grey),
                        onPressed: () {
                          setState(() {
                            adhkarItem.isFavorite =
                            !adhkarItem.isFavorite;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          _playAudio(adhkarItem.audio);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            adhkarItem.count++;
                          });
                        },
                        child: Text(adhkarItem.count.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
