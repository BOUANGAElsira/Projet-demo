import 'package:flutter/material.dart';

class SearchController extends StatefulWidget {
  const SearchController({super.key});

  @override
  State<SearchController> createState() => _SearchControllerState();
}

class _SearchControllerState extends State<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Controller'),
    );
  }
}
