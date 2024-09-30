import 'package:flutter/material.dart';
import 'package:fluttersample1/database/movies_database.dart';
import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:fluttersample1/views/movie_view.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MoviesDatabase moviesDB = MoviesDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies List',
        ),
        actions: [
          IconButton(
              onPressed: () {
                WoltModalSheet.show(
                    context: context,
                    pageListBuilder: (context) =>
                        [WoltModalSheetPage(child: MovieView())]);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.banUpdListMovies,
          builder: (context, value, Widget) {
            return FutureBuilder(
                future: moviesDB.SELECT(),
                builder: (context, AsyncSnapshot<List<Moviesdao>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MovieViewItem(Moviesdao: snapshot.data![index]);
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Something is wrong!!'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                });
          }),
    );
  }

  Widget MovieViewItem({required Moviesdao}) {
    return Text('');
  }
}
