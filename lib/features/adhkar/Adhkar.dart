import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

import '../../models/AdhkarItem .dart';

class Adhkar extends StatefulWidget {
  const Adhkar({Key? key}) : super(key: key);

  @override
  _AdhkarState createState() => _AdhkarState();
}

class _AdhkarState extends State<Adhkar> {
  List<AdhkarItem>? _adhkarItems;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAdhkarData();
  }

  Future<void> _loadAdhkarData() async {
    final String jsonString =
    await rootBundle.loadString('assets/adhkar.json');
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

  void _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'أذكار',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: _adhkarItems == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _adhkarItems!.length,
        itemBuilder: (context, index) {
          final adhkarItem = _adhkarItems![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdhkarDetails(adhkarItem: adhkarItem),
                ),
              );
            },
            child: Card(
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
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      adhkarItem.array[0]['text'],
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () {
                            _stopAudio();
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
            ),
          );
        },
      ),
    );
  }
}


class AdhkarDetails extends StatelessWidget {
  final AdhkarItem adhkarItem;

  const AdhkarDetails({required this.adhkarItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          adhkarItem.category,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              adhkarItem.array[0]['text'],
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    // Play audio logic here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    // Stop audio logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
