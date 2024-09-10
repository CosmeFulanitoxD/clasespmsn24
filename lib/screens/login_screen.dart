import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conuser = TextEditingController();
  final conPwd = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conuser,
      decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
    );
    TextFormField txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      controller: conPwd,
      decoration: InputDecoration(prefixIcon: Icon(Icons.password)),
    );
    final ctnCredentials = Positioned(
      bottom: 100,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtPwd],
        ),
      ),
    );

    final btnLogin = Positioned(
        bottom: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[200]),
            onPressed: () {
              isloading = true;
              setState(() {});
              Future.delayed(Duration(milliseconds: 4000)).then((value) => {
                    isloading = false,
                    setState(() {}),
                    Navigator.pushNamed(context, "/home")
                  });
            },
            child: const Text('Validar usuario')));

    final gifloading =
        Positioned(top: 5, child: Image.asset('assets/yosh.gif'));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/pap.jpg'),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 100,
                child: Image.asset(
                  'assets/huntz.png',
                  width: 160,
                )),
            ctnCredentials,
            btnLogin,
            isloading ? gifloading : Container()
          ],
        ),
      ),
    );
  }
}
