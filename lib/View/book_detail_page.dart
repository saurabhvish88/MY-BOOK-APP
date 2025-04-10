import 'package:flutter/material.dart';
import 'package:project/Model/book.dart';
import 'package:project/Viewmodel/book_view_model.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        actions: [
          IconButton(
            icon: Icon(
              viewModel.isFavourite(book)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => viewModel.toggleFavourite(book),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (book.coverUrl != null)
              Center(child: Image.network(book.coverUrl!, height: 200)),
            SizedBox(height: 20),
            Text(book.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Author: ${book.author}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
