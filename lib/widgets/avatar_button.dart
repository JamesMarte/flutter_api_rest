import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({super.key, this.imageSize=100,});

  @override
  Widget build(BuildContext context) {
    return   Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                       color: Colors.black26,
                       offset: Offset(0,20)
                      ),
                    ],
                  ),
                  child: ClipOval(
                  child: Image.network('https://thumbs.dreamstime.com/z/%D0%BF%D0%B5%D1%87%D0%B0%D1%82%D1%8C-woman-avatar-profile-female-face-icon-vector-illustration-190750711.jpg',
                width: this.imageSize,
                height: this.imageSize,),
                ),
                ),
                //Boton de la imagen del icono
                Positioned(
                  bottom: 5,
                  right: 0,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: Icon(Icons.add,
                        color: Colors.white,
                        ),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,
                          width: 2),
                          color: Colors.pink,
                          shape: BoxShape.circle,
                  
                        ),
                        ),
                    onPressed: () {},
                    ),
                ),
              ],
            );
  }
}