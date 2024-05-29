import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/api/authentication_api.dart';
import 'package:flutter_rest_api/data/authentication_client.dart';
import 'package:flutter_rest_api/pages/home_page.dart';
import 'package:flutter_rest_api/utils/dialogs.dart';
import 'package:flutter_rest_api/utils/responsive.dart';
import 'package:get_it/get_it.dart';
import 'input_text.dart';
class RegisterForm extends StatefulWidget {
 // const LoginForm({super.key});
 @override
 _RegisterFormState createState() => _RegisterFormState();
}
class _RegisterFormState extends State<RegisterForm> {
  final _authenticationAPI=GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email='', _password='', _username='';
 


  Future<void> _submit() async {//metodo privado
 final isOk = _formKey.currentState?.validate() ?? false;

 if(isOk){
  ProgressDialog.show(context);
  final response = await _authenticationAPI.register(//await para esperar que termine la tarea
    username: _username,
    email: _email,
    password: _password 
    );
    ProgressDialog.dissmiss(context);
    if(response.data != null){
     await _authenticationClient.saveSession(response.data!);
      Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false,);
    }else{
      //Para mostrar los errores en la pantalla
      String message = response.error!.message;
      if(response.error?.statusCode == -1){
        message = "Bad network";
      }else if (response.error?.statusCode == 409){
        message = "Duplicated user ${jsonEncode(response.error!.data['duplicatedFields'])}";
      }
      Dialogs.alert(context, title: "ERROR", description: message);
    }
    }
  }

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430:360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
          InputText(
            keyboardType: TextInputType.emailAddress,
            label: "USERNAME",
            fontSize: responsive.dp(responsive.isTablet ? 1.2: 1.4),
            onChanged: (text){
              _username = text;
            },
            validator: (text){
              if(text!.trim().length < 5){
                return "invalid username";
              }
              return null;
            },
            ),
            SizedBox(height: responsive.dp(2)),
             InputText(
            keyboardType: TextInputType.emailAddress,
            label: "EMAIL ADDRESS",
            fontSize: responsive.dp(responsive.isTablet ? 1.2: 1.4),
            onChanged: (text){
              _email = text;
            },
            validator: (text){
              if(text == null || !text.contains("@")){
                return "invalid email";
              }
              return null;
            },
            ),
            SizedBox(height: responsive.dp(2)),
             InputText(
            keyboardType: TextInputType.emailAddress,
            label: "PASSWORD",
            obscureText: true,
            fontSize: responsive.dp(responsive.isTablet ? 1.2: 1.4),
            onChanged: (text){
              _password = text;
            },
            validator: (text){
              if(text!.trim().length < 6){
                return "invalid password";
              }
              return null;
            },
            ),
            SizedBox(height: responsive.dp(5)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Sing up",
              style: TextStyle(color: Colors.white,
              fontSize: responsive.dp(1.5),
              ),
            ),
          ),
           onPressed: _submit,
              ),
            ),
          ),
              SizedBox(height: responsive.dp(2)),
              Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text("ALready have an account?", 
              style: TextStyle(fontSize: responsive.dp(1.5),
              ),
              ),
              TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Sing in",
              style: TextStyle(color: Colors.pinkAccent, fontSize: responsive.dp(1.5),
              ),
              ),
              ),
              ],
              ),
              SizedBox(height: responsive.dp(10),),
              ],
              ),
        ),
      ),
    );
  }
}