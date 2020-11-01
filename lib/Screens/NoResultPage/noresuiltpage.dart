import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class NoResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(children: [
          Icon(CommunityMaterialIcons.file_search,size: 100,color: Colors.purple[700],),
        ],),
        
      ),
    );
  }
}