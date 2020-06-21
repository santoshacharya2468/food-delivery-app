import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../conf.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final nameController = new TextEditingController();
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(hintText: "Email"),
                              maxLength: 250,
                              validator: (email) {
                                if (email.isEmpty) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Password",
                                  border: UnderlineInputBorder()),
                              maxLength: 14,
                              validator: (password) {
                                if (password.isEmpty) {
                                  return "Password is required";
                                }
                                if (password.length < 6) {
                                  return "Password must be 6 character long";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Your name",
                                  border: UnderlineInputBorder()),
                              maxLength: 20,
                              validator: (name) {
                                if (name.isEmpty) {
                                  return "name is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                  height: 45.0,
                                  child: Builder(
                                    builder: (context) {
                                      return RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: isProcessing
                                            ? null
                                            : () async {
                                                if (formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    isProcessing = true;
                                                  });
                                                  Dio dio = Dio(BaseOptions(
                                                      headers: {
                                                        "apikey": apiKey,
                                                      },
                                                      validateStatus:
                                                          (status) => true,
                                                      baseUrl: baseUrl));
                                                  //make http request to server
                                                  try {
                                                    var response = await dio
                                                        .post(
                                                            "account/register",
                                                            data: {
                                                          "email":
                                                              emailController
                                                                  .text,
                                                          "password":
                                                              passwordController
                                                                  .text,
                                                          "name": nameController
                                                              .text
                                                        });
                                                    setState(() {
                                                      isProcessing = false;
                                                    });
                                                    if (response.statusCode ==
                                                        201) {
                                                      Navigator.pop(context);
                                                        
                                                    // } else if (response
                                                    //         .statusCode ==
                                                    //     400) {
                                                    //   Scaffold.of(context)
                                                    //       .showSnackBar(
                                                    //           SnackBar(
                                                    //     content: Text(response
                                                    //         .data['message']),
                                                    //     backgroundColor:
                                                    //         Colors.red[400],
                                                    //   ));
                                                    } else {
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            response.data['message']),
                                                        backgroundColor:
                                                            Colors.red[400],
                                                      ));
                                                    }
                                                  } catch (e) {
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Internet Error"),
                                                      backgroundColor:
                                                          Colors.red[400],
                                                    ));
                                                  }
                                                } else {
                                                  //do nothing;
                                                }
                                              },
                                        child: Center(child: Text("Register",style: TextStyle(
                                          color: Colors.white,
                                        ),)),
                                      );
                                    },
                                  ))),
                        ],
                      ),
                    ),
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
