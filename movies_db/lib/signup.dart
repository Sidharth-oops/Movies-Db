import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_db/functions/auth_functions.dart';
import 'package:movies_db/login.dart';

import 'consts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [g1, g2],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.030),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: size.height * 0.014,
                children: [
                  Image.asset(image1),
                  Text(
                    "Hi there!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: kWhiteColor.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "Let's Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: kWhiteColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.024,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!(value.toString().contains('@'))) {
                        return 'Email is not valid';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      setState(() {
                        email = newValue!;
                      });
                    },
                    key: ValueKey('email'),
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: kInputColor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 25),
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(userIcon),
                      ),
                      fillColor: kWhiteColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if ((value.toString().length < 6)) {
                        return 'Password is not valid';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      setState(() {
                        password = newValue!;
                      });
                    },
                    key: ValueKey('password'),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: kInputColor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 25),
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(keyIcon),
                      ),
                      fillColor: kWhiteColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(37)),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        signUp(email, password,context);
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.014,
                  ),
                  SvgPicture.asset("assets/icons/deisgn.svg"),
                  SizedBox(
                    height: size.height * 0.014,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 45,
                              spreadRadius: 0,
                              color: Color.fromRGBO(120, 37, 139, 0.25),
                              offset: Offset(0, 25))
                        ],
                        color: Color.fromRGBO(225, 225, 225, 0.28),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
