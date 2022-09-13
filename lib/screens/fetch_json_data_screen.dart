import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/album.dart';

class FetchJsonDataScreen extends StatelessWidget {
  const FetchJsonDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Fetch Json Data'),
            const SizedBox(height: 5,),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: 'This will show: '),
                  TextSpan(text: 'UserID / Album title', style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),

      ),
      body: const SafeArea(
        child: FetchJsonDataWidget(),
      ),
    );
  }
}

class FetchJsonDataWidget extends StatefulWidget {
  const FetchJsonDataWidget({Key? key}) : super(key: key);

  @override
  State<FetchJsonDataWidget> createState() => _FetchJsonDataWidgetState();
}

class _FetchJsonDataWidgetState extends State<FetchJsonDataWidget> {
  late Future<List<Album>> futureAlbumsList;

  @override
  void initState() {
    super.initState();
    futureAlbumsList = fetchAlbumsList();
  }

  Future<List<Album>> fetchAlbumsList() async {
    final response = await http.get(Uri.parse(kAlbumsUrl));

    if(response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((album) => Album.fromJson(album))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: futureAlbumsList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final albumsList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: albumsList.length,
            itemBuilder: (context, index) {
              final Album album = albumsList[index];
              return ListTile(
                leading: CircleAvatar(child: Text(album.userId.toString())),
                title: Text(album.title),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

