import 'package:flutter/material.dart';
import 'package:flutter_rest_api/utils/responsive.dart';
import 'package:flutter_rest_api/widgets/circle.dart';
import 'package:flutter_rest_api/widgets/icon_container.dart';
import 'package:flutter_rest_api/widgets/login_form.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = 'login';

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
  final Responsive responsive = Responsive.of(context);

   final double pinkSize = responsive.wp(80);
      final double orangeSize = responsive.wp(57);

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
          width: double.infinity,
          height: responsive.heigth,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center, //Para alinear
            children: <Widget>[
           Positioned( //Circulo rosa
                top: -pinkSize * 0.4,
                right: -pinkSize * 0.2,
                child: Circle(
              size: pinkSize,
              colors: [
                Colors.pinkAccent,
                Colors.pink,
              ],
          ),
          ),
            Positioned(//Circulo naranja
                top: -orangeSize * 0.55,
                left: -orangeSize * 0.15,
                child: Circle(
              size: orangeSize,
              colors: [
                Colors.orange,
                Colors.deepOrangeAccent,
              ],
          ),
          ),
          Positioned(//Icono
            top: pinkSize * 0.35,
            child: Column(
            children: <Widget>[ 
            IconContainer(
              size: responsive.wp(17),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Hello Again\nWelcome Back!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: responsive.dp(2),
             ),
            )
            ],
            ),
          ),
        
          LoginForm()
            ],
             )
                       ,)
                       ,)
      )
    );
  }
}