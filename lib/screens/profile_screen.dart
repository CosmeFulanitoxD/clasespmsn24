import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double coverHeight = 280;
  double profileHeight = 144;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen(
      (state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    );
    audioPlayer.onDurationChanged.listen((newDuration){
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition){
      setState(() {
        position = newPosition;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network('https://m.media-amazon.com/images/I/81wMjyoAdwL.jpg',
            width: double.infinity,
            height: 350,
            fit: BoxFit.cover,),
          ),
          const SizedBox(height: 32),
          const Text('Negro grips',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
          ),
          const SizedBox(height: 4,),
          const Text('death grips',
          style: TextStyle(fontSize: 20),),
          Slider(min: 0,max: duration.inSeconds.toDouble(),value: position.inSeconds.toDouble(), onChanged: (value) async{},
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(position)),
              Text(formatTime(duration)),
            ],
          ),
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(icon: Icon(isPlaying ? Icons.pause: Icons.play_arrow),
            iconSize: 50,
            onPressed:() async {
              if(isPlaying){
                await audioPlayer.pause();
              } else{
                await audioPlayer.play(AssetSource('deathgrips.mp3'));
              }
            },),
          ),
          rate()
        ]
        )
      );
  }

  Widget builCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          "assets/portada.jpg",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfile() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: ExactAssetImage("assets/profile.jpg"),
      );

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight /2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: builCoverImage()
          ),
        Positioned(top: top, child: buildProfile()),
      ],
    );
  }
  
  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8,),
      Text('Max Palma', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)
      ),
      const SizedBox(height: 8),
      Text('Student',
      style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(Icons.mail,1),
          const SizedBox(width:12),
          buildSocialIcon(Icons.phone,2),
          const SizedBox(width:12),
          buildSocialIcon(FontAwesomeIcons.github,3),       
        ],
      )


      
    ],
  );
  
  Widget rate(){
    return AnimatedRatingStars(
  initialRating: 3.5,
  minRating: 0.0,
  maxRating: 5.0,
  filledColor: Colors.amber,
  emptyColor: Colors.grey,
  filledIcon: Icons.star,
  halfFilledIcon: Icons.star_half,
  emptyIcon: Icons.star_border,
  onChanged: (double rating) {
    // Handle the rating change here
    print('Rating: $rating');
  },
  displayRatingValue: true,
  interactiveTooltips: true,
  customFilledIcon: Icons.star,
  customHalfFilledIcon: Icons.star_half,
  customEmptyIcon: Icons.star_border,
  starSize: 30.0,
  animationDuration: Duration(milliseconds: 300),
  animationCurve: Curves.easeInOut,
  readOnly: false,
);
  }

  Widget buildSocialIcon(IconData icon, int ids) => CircleAvatar(
    radius: 25,
    child: Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,

      child: InkWell(
        onTap: (){
          switch (ids) {
            case 1:
            Uri uri = Uri.parse('https://mail.google.com/mail/u/2/?pli=1#inbox?compose=CllgCHrgldqvbFxqMGZfFvwqGsrtNmTGMQdCzQHPkXXRvJbtNTHgJJQcxgmmphCvjRNclwsSsWL');
            launcher.launchUrl(uri, mode: launcher.LaunchMode.externalApplication);
              break;
            case 2:
            Uri uri = Uri.parse('tel:+55-461-385-7115');
            launcher.launchUrl(uri);
              break;
            case 3:
              Uri uri = Uri.parse('https://github.com/CosmeFulanitoxD');
            launcher.launchUrl(uri, mode: launcher.LaunchMode.externalApplication);
              break;
            default:
          }
        },
        child: Center(
        child: Icon(
          icon,size: 32,
          ),
          ),
      ),)
  );
  
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
