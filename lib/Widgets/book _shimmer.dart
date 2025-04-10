import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: ListTile(
        leading: Container(height: 50, width: 40, color: Colors.white),
        title: Container(height: 15, color: Colors.white),
        subtitle: Container(height: 12, color: Colors.white),
      ),
    );
  }
}
