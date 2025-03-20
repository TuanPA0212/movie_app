import 'package:flutter/material.dart';
import 'package:movie_app/core/debounce.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/viewmodels/textFieldProvider.dart';
import 'package:provider/provider.dart';

import '../../core/api_constants.dart';
import '../../viewmodels/movie_view_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(context) {
    final TextEditingController _controller = TextEditingController();
    final Debouncer _debouncer = Debouncer(milliseconds: 1000);

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(
                height: 40,
                child: Consumer<TextFieldProvider>(
                    builder: (context, textFieldProvider, child) {
                  return TextField(
                    controller: _controller,
                    onChanged: (value) {
                      textFieldProvider.updateText(value);
                      _debouncer.run(() {
                        context.read<MovieViewModel>().searchMovies(value);
                      });
                    },
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: AppColors.searchText,
                      suffixIcon: textFieldProvider.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                textFieldProvider.clearText();
                                _controller.clear();
                              })
                          : null,
                      suffixIconColor: AppColors.searchText,
                      filled: true,
                      hintText: "Searching...",
                      hintStyle: TextStyle(color: AppColors.searchText),
                      border: OutlineInputBorder(),
                      fillColor: AppColors.searchBar,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  );
                })),
          )),
      body: SearchBodyNew(),
    );
  }
}

class SearchBodyNew extends StatefulWidget {
  const SearchBodyNew({super.key});

  @override
  State<SearchBodyNew> createState() => _SearchBodyNewState();
}

class _SearchBodyNewState extends State<SearchBodyNew> {
  late MovieViewModel movieViewModel;

  @override
  void initState() {
    super.initState();
    movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    movieViewModel.setIsFirstSearch(false);
    movieViewModel.searchMoviesList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(builder: (context, movieProvider, child) {
      final searchMovies = movieProvider.searchMoviesList;

      if (movieProvider.isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (searchMovies.isEmpty && movieProvider.isFirstSearch) {
        return Center(child: Text("No movies found"));
      }

      return Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: searchMovies.length,
          itemBuilder: (context, index) {
            final movie = movieProvider.searchMoviesList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[300], // Màu nền khi ảnh lỗi
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image,
                            size: 50, color: Colors.grey[600]),
                        SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
