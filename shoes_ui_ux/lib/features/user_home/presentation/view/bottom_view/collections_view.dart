import 'package:flutter/material.dart';

class CollectionView extends StatefulWidget {
  const CollectionView({ Key? key }) : super(key: key);

  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Favorite"),
    );
  }
}