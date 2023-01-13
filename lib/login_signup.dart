import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadd/view/home_page.dart';

import 'package:foodadd/main.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;


    var tfMailController = TextEditingController();
    var tfPassController = TextEditingController();


    return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  //width: ekranGenisligi/2,
                    child: Image.asset("images/foodadd_logo.png")
                ),
              ),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfMailController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30,),

              Padding(
                padding: EdgeInsets.all(ekranYuksekligi/100),
                child: TextField(
                  controller: tfPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText:"Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async{
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );


                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: tfMailController.text.trim(),
                          password: tfPassController.text.trim(),
                        );

                        print("Successful");

                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }

                      navigatorKey.currentState!.popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25,),

              const Text("Help ? ",
                style: TextStyle(
                fontSize: 25,
                color: Colors.white
              ),),
            ],
          ),
        ),
    );
  }
}