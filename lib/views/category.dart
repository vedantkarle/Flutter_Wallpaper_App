import 'dart:convert';
import 'package:WallpapersHub/data/data.dart';
import 'package:WallpapersHub/models/wallpaper_model.dart';
import 'package:WallpapersHub/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String categoryName;

  Category({this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = TextEditingController();

  getCategoryWallpapers(String query) async {
    String url =
        'https://api.pexels.com/v1/search?query=$query&per_page=15&page=1';

    var response = await http.get(url, headers: {
      "Authorization": apiKey,
    });

    Map<String, dynamic> _jsonData = json.decode(response.body);

    _jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getCategoryWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}
