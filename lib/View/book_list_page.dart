import 'package:flutter/material.dart';
import 'package:project/Viewmodel/book_view_model.dart';
import 'package:project/Widgets/book%20_shimmer.dart';
import 'package:provider/provider.dart';

import '../widgets/book_card.dart';
import 'book_detail_page.dart';
import 'favourites_page.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('📚 MyBooks'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FavouritesPage()));
                },
              ),
              if (viewModel.favourites.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      viewModel.favourites.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                viewModel.filterBooks(value);
              },
              decoration: InputDecoration(
                hintText: '🔍 Search books...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (viewModel.isLoading && viewModel.books.isEmpty) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (_, __) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: BookShimmer(),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent &&
                  !viewModel.isLoading) {
                viewModel.fetchBooks();
              }
              return true;
            },
            child: ListView.builder(
              itemCount: viewModel.filteredBooks.length + 1,
              itemBuilder: (context, index) {
                if (index < viewModel.filteredBooks.length) {
                  final book = viewModel.filteredBooks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookDetailPage(book: book)),
                      );
                    },
                    child: BookCard(book: book),
                  );
                } else {
                  return viewModel.isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
