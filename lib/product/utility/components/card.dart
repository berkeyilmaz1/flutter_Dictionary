import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/product/model/model.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.model});

  final DictionaryModel model;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playAudio(String url) async {
    int result = await _audioPlayer.play(url);
    if (result == 1) {}
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.model.word?.toUpperCase() ?? " ",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (widget.model.phonetics != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.model.phonetics!.map((phonetic) {
                      return phonetic.audio != null &&
                              phonetic.audio!.isNotEmpty
                          ? Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.volume_up_rounded),
                                  onPressed: () => _playAudio(phonetic.audio!),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    }).toList(),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (widget.model.meanings != null)
              for (var meaning in widget.model.meanings!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meaning.partOfSpeech ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ), //noun-verb etc.
                    if (meaning.definitions != null)
                      for (var definition in meaning.definitions!)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "- ${definition.definition}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ), //definitions
                  ],
                ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
