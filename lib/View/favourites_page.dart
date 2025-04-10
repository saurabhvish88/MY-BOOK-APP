import 'package:flutter/material.dart';
import 'package:project/Viewmodel/book_view_model.dart';
import 'package:provider/provider.dart';
import '../widgets/book_card.dart';
import 'book_detail_page.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookViewModel>(context);
    final favourites = viewModel.favourites;

    return Scaffold(
      appBar: AppBar(title: Text("Favourites")),
      body: favourites.isEmpty
          ? Center(child: Text("No Favourites yet!"))
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final book = favourites[index];
                return Dismissible(
                  key: Key(book.title),
                  background: Container(color: Colors.red),
                  onDismissed: (_) => viewModel.removeFromFavourites(book),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookDetailPage(book: book)),
                    ),
                    child: BookCard(book: book),
                  ),
                );
              },
            ),
    );
  }
}
