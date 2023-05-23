// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sklps_app/screens/authenticate/sign_in.dart';
import 'package:sklps_app/screens/support.dart';
import 'package:sklps_app/services/auth.dart';
import 'package:sklps_app/services/error_handling.dart';
import 'package:sklps_app/shared/constants.dart';
import 'package:sklps_app/shared/size_config.dart';
import 'package:sklps_app/shared/text_filed_validation.dart';

//Purpose: Register screen UI for users to create an account
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //helps control flow between SignIn and Register page
  changeShowRegister() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  //keeps track of whether show SignIn or Register Page
  bool showRegister = true;

  //stores user entered info from TextFormField or error message
  String _error = "";
  String _email = ""; //stores user info
  String _password = ""; //stores user info

  ErrorHandling errorHandler = new ErrorHandling();

  //controls state of TextFormField and handles validation
  final TextFieldValidation _validate = TextFieldValidation();
  final _globalKey = GlobalKey<FormState>();

  //whether show or hide password
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    //on change of var --> go to SignIn page
    if (!showRegister) {
      return SignIn();
    }

    final authService = Provider.of<AuthService>(context);

    return Material(
      child: SafeArea(
        child: Container(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          decoration: boxDecorationBackground,
          child:
              Padding(
            padding: EdgeInsets.fromLTRB(
                SizeConfig.safeBlockHorizontal * 5,
                SizeConfig.safeBlockVertical * 2,
                SizeConfig.safeBlockHorizontal * 5,
                SizeConfig.safeBlockVertical * 2),
            //Form connects all TextFormFields
            child: Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 35,
                      child: Image.asset(
                        'assets/images/sklps_logo.png',
                        width: SizeConfig.safeBlockVertical * 35,
                        height: SizeConfig.safeBlockVertical * 35,
                      ),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 3,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 9.5,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style:
                            TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                        decoration: InputDecoration(
                            hintText: "Email",
                            //for text below TextFormField
                            errorStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            helperText: "",
                            helperStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            prefixIcon: SizedBox(
                              height: SizeConfig.safeBlockVertical * 2.5,
                              width: SizeConfig.safeBlockHorizontal * 2.5,
                              child: Icon(
                                Icons.email,
                              ),
                            ),),
                        maxLines: 1,
                        validator: (value) {
                          //checks if user entered email is valid --> otherwise can't register
                          return _validate.validateEmail(value?.trim());
                        },
                        onChanged: (value) {
                          //everytime user makes a change --> email is updated
                          setState(() => _email = value.trim().toLowerCase());
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 9.5,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style:
                            TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                        decoration: InputDecoration(
                            hintText: "Password",
                            //text below TextFormField
                            errorStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            helperText: "",
                            helperStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            prefixIcon: SizedBox(
                              height: SizeConfig.safeBlockVertical * 2.5,
                              width: SizeConfig.safeBlockVertical * 2.5,
                              child: Icon(
                                Icons.lock,
                              ),
                            ),
                            //IconButton determines whether password is revealed or not
                            suffixIcon: IconButton(
                              //changes eye icon based on whether password is revealed or hidden
                              icon: Icon(_obscurePassword
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                                size: SizeConfig.safeBlockVertical * 2.5,),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            )),
                        obscureText: _obscurePassword,
                        maxLines: 1,
                        validator: (value) {
                          //checks whether user entered password is valid
                          return _validate.validatePassword(value?.trim());
                        },
                        onChanged: (value) {
                          //everytime user changes TextFormField --> password is updated
                          setState(() => _password = value.trim());
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 9.5,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style:
                            TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                        decoration: InputDecoration(
                            hintText: "Password",
                            errorStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            helperText: "",
                            helperStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 2),
                            prefixIcon: SizedBox(
                              height: SizeConfig.safeBlockVertical * 2.5,
                              width: SizeConfig.safeBlockVertical * 2.5,
                              child: Icon(
                                Icons.lock,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                                size: SizeConfig.safeBlockVertical * 2.5,),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            )),
                        obscureText: _obscurePassword,
                        maxLines: 1,
                        validator: (value) {
                          return _validate.validateConfirmPassword(
                              value?.trim(), _password);
                        },
                      ),
                    ),
                    //Text displays error message based on error returned from auth.register
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _error,
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: SizeConfig.safeBlockVertical * 2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 3,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 6,
                      child: ElevatedButton(
                        child: TextDefault(
                          text: "Register",
                          color: Colors.white,
                          sizeMultiplier: 2.5,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[1000],
                          shadowColor: Colors.black12,
                          fixedSize: Size(SizeConfig.safeBlockHorizontal * 30,
                              SizeConfig.safeBlockVertical * 6),
                          textStyle: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2.5,
                          ),
                        ),
                        onPressed: () async {
                          //if validate is not true --> reset error text beneath textFormFields
                          if (!_globalKey.currentState!.validate()) {
                            //referenced https://codewithandrea.com/articles/flutter-text-field-form-validation/ for textformfield validation
                            setState(() {
                              _error = "";
                            });
                            return;
                          }
                          try {
                            await authService.registerWithEmailAndPassword(
                                _email, _password);
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              print(_error);
                              //sets error to error code returned by error handler
                              _error = errorHandler.errorHandling(e.code);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 6,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextDefault(
                              text: "Already have an account?",
                              color: Colors.black,
                              sizeMultiplier: 2,
                            ),
                            TextButton(
                              child: TextDefault(
                                text: "Sign In",
                                color: Colors.black,
                                sizeMultiplier: 2,
                                bold: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              style: TextButton.styleFrom(
                                fixedSize: Size(SizeConfig.safeBlockHorizontal * 20,
                                    SizeConfig.safeBlockVertical * 6),
                                textStyle: TextStyle(
                                    fontSize: SizeConfig.safeBlockVertical * 2.5,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              //Navigates to SignIn Page by reloading state
                              onPressed: () {
                                changeShowRegister();
                              },
                            ),
                          ]),
                    ),
                    //Positioning for support page button
                    Container(
                      height: SizeConfig.safeBlockVertical * 3.5,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          child: Icon(
                            FontAwesomeIcons.circleQuestion,
                            size: SizeConfig.safeBlockVertical * 4,
                          ),
                          backgroundColor: Colors.blue[1000],
                          //Calls support page pop up
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Support(
                                      dialogBox: false,
                                      signOutButton: false,
                                    )));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
