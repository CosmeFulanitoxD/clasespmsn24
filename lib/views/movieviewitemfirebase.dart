import 'package:flutter/material.dart';
import 'package:fluttersample1/firebase/dbmovies.dart';
import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:fluttersample1/views/movie_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItemFirebase extends StatefulWidget {
  MovieViewItemFirebase(
      {super.key, required this.moviesDAO, required this.Uid});

  final MoviesDAO moviesDAO;
  final Uid;

  @override
  State<MovieViewItemFirebase> createState() => _MovieViewItemFirebaseState();
}

class _MovieViewItemFirebaseState extends State<MovieViewItemFirebase> {
  Dbmovies? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = Dbmovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(children: [
            Image.network(
              widget.moviesDAO.imgMovie!,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: ListTile(
                title: Text(widget.moviesDAO.nameMovie!),
                subtitle: Text(widget.moviesDAO.releaseDate!),
              ),
            ),
            IconButton(
              onPressed: () {
                WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: MovieView(moviesdao: widget.moviesDAO),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.edit),
            

               IconButton(
                 onPressed: () {
                   moviesDatabase!
                       .delete(widget.Uid)
                       .then((value) {
                     if (value) {
                       //GlobalValues.banUpdListMovies.value =
                         //  !GlobalValues.banUpdListMovies.value;
                       QuickAlert.show(
                         context: context,
                         type: QuickAlertType.success,
                         text: 'Deleted successfully!',
                         autoCloseDuration: const Duration(seconds: 2),
                         showConfirmBtn: false,
                       );
                     } else {
                       QuickAlert.show(
                         context: context,
                         type: QuickAlertType.error,
                         text: 'Deletion failed',
                         autoCloseDuration: const Duration(seconds: 2),
                         showConfirmBtn: false,
                       );
                     }
                   });
                 },
                 icon: const Icon(Icons.delete),
               ),
             ],
          ]),
        ],
      ),
    );
  }
}
