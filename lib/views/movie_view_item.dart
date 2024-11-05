import 'package:flutter/material.dart';
import 'package:fluttersample1/database/movies_database.dart';
import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:fluttersample1/views/movie_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItem extends StatefulWidget {
  MovieViewItem({
    super.key,
    required this.moviesdao,
  });

  MoviesDAO moviesdao;

  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItem> {
  @override
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blueAccent),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                'https://media.themoviedb.org/t/p/w500/5lHMB2jwlQV43RBfT5g3BRGN0Tm.jpg',
                height: 120,
              ),
              Expanded(
                child: ListTile(
                  title: Text(widget.moviesdao.nameMovie!),
                  subtitle: Text(widget.moviesdao.releaseDate!),
                ),
              ),
              IconButton(
                  onPressed: () {
                    WoltModalSheet.show(
                        context: context,
                        pageListBuilder: (context) => [
                              WoltModalSheetPage(
                                  child: MovieView(
                                moviesdao: widget.moviesdao,
                              ))
                            ]);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    moviesDatabase!
                        .DELETE('tblmovies', widget.moviesdao.idMovie!)
                        .then((value) {
                      if (value > 0) {
                        GlobalValues.banUpdListMovies.value =
                            !GlobalValues.banUpdListMovies.value;
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Transaction Completed Successfully!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                      } else {
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Transaction wrong!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          Divider(),
          Text(widget.moviesdao.overview!),
        ],
      ),
    );
  }
}
