import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tailor_app_final_final/account_creations/account_creations.dart';
import 'package:tailor_app_final_final/provider/change_pwd_icon.dart';
import 'package:tailor_app_final_final/screens/dashboard.dart';
import 'package:tailor_app_final_final/utils/widgets.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  static bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: <Widget>[
          SizedBox(
            width: width,
            height: height * 0.4,
            child: const Image(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/logo.png',
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CommonWidgets.customTextFormField(
                    hintText: 'Email',
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined)),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Consumer<ChangeIcon>(
                      builder: (context, value, child) =>
                          CommonWidgets.customTextFormField(
                              hintText: 'Password',
                              obscureText: isObscured,
                              controller: _pwdController,
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isObscured = !isObscured;
                                  value.changeIcon(isObsecured: isObscured);
                                },
                                icon: value.isObsecure
                                    ? const Icon(Icons.visibility_off_sharp)
                                    : const Icon(Icons.visibility_outlined),
                              ),
                              textInputType: TextInputType.visiblePassword),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.55, top: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ResetPassword(),
                          ));
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.teal)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                CommonWidgets.customBtn(
                    onPressed: () async {
                      if (!_emailController.text.contains('@') ||
                          !_emailController.text.contains('.') ||
                          _emailController.text.isEmpty ||
                          _pwdController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: !_emailController.text.contains('@') ||
                                  !_emailController.text.contains('.') ||
                                  _emailController.text.isEmpty
                              ? 'Invalid or Empty Email'
                              : 'Password can\'t be Empty',
                          backgroundColor: Colors.black,
                        );
                      } else {
                        if (await InternetConnectionChecker().hasConnection) {
                          final status =
                              await LoginProvider.signInWithEmailAndPWD(
                                  email: _emailController.text,
                                  password: _pwdController.text);
                          LoginProvider.customSnackBar(
                              status: status, context: context);
                          if (status == 'Signed In Successfully') {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: const DashBoard()));
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Internet Not Available');
                        }
                      }
                    },
                    name: 'Login',
                    height: height * 0.06,
                    width: width),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: CommonWidgets.customBtn(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: SignUp()));
                      },
                      name: 'Register Email',
                      height: height * 0.06,
                      width: width),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Divider(
                color: Color(0xD2EA4A26),
                indent: 50,
                endIndent: 50,
                thickness: 1,
              )),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.02, left: width * 0.15, right: width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                    backgroundColor: const Color(0xD2EA4A26),
                    radius: 25,
                    child: IconButton(
                        onPressed: () async {
                          if (await InternetConnectionChecker().hasConnection) {
                            final status =
                                await LoginProvider.signInWithGoogle();
                            LoginProvider.customSnackBar(
                                status: status, context: context);
                          } else {
                            LoginProvider.customSnackBar(
                                status: 'Internet Connection not available',
                                context: context);
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.google,
                            color: Colors.white))),
                //    Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                //   child: IconButton(
                //     onPressed: () async {
                //       if (await InternetConnectionChecker().hasConnection) {
                //         final status = await LoginProvider.signInWithFacebook(
                //             context: context);
                //         LoginProvider.customSnackBar(
                //             status: status, context: context);
                //       } else {
                //         LoginProvider.customSnackBar(
                //             status: 'Internet Connection not available',
                //             context: context);
                //       }
                //     },
                //     iconSize: 50,
                //     icon: const Icon(
                //       FontAwesomeIcons.facebook,
                //       color: Color(0xD2EA4A26),
                //       size: 50,
                //     ),
                //   ),
                // ),
                CircleAvatar(
                  backgroundColor: const Color(0xD2EA4A26),
                  radius: 25,
                  child: IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const PhoneNumberAuth()));
                      },
                      icon: const Icon(FontAwesomeIcons.phone,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ]),
      )),
    ));
  }
}
