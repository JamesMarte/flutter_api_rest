import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {

  final double size;
  const IconContainer({super.key, required this.size}) : assert(size!= null && size>0);

  @override
  Widget build(BuildContext context) {
    return Container(
      //Tamaño del icon
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(//Decoracion del icono
              color: Colors.white,
              borderRadius: BorderRadius.circular(this.size*0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 25,
                  offset: Offset(0,15),
                ),
              ],
      ),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(child:SvgPicture.asset('assets/icon.svg', 
      width: this.size * 0.6,
      height: this.size * 0.6,
      
      ) ,
      ),
    );
  }
}