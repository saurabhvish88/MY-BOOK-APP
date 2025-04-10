import 'package:flutter/material.dart';
import 'package:project/Model/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
      ),
      child: ListTile(
        leading: book.coverUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    Image.network(book.coverUrl!, width: 50, fit: BoxFit.cover),
              )
            : Icon(Icons.book, size: 40),
        title: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(book.author ?? 'Unknown'),
        trailing: Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }
}
