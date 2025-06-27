import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/homepage.dart';
import 'package:tomatooo_app/Screens/Sign_up_Register_Page.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});
  static String id = 'RegisterPage';
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://tomato-sigma-five.vercel.app/api/v1/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully signed in
        if (mounted) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        }
      } else {
        // Handle error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed: ${response.body}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.leaf,
                      size: 35,
                      color: kPraimaryColor,
                    ),
                    SizedBox(width: 15),
                    Icon(
                      FontAwesomeIcons.cartShopping,
                      size: 35,
                      color: kPraimryTextTwoColor,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Tomato Connect',
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Connecting farmers and buyers',
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sign in to your account to continue',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(activeColor:Colors.green,value: isChecked, onChanged: (bool? value) {
                                setState(() {
                                  isChecked =value ?? false;
                                });
                              }),
                              const Text('Remember me'),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: kPraimaryColor,
                                    fontFamily: kFontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            // onTap: _isLoading ? null : _signIn,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                HomePage.id,
                              );
                            },
                            child: CustomButton(
                              title: _isLoading ? 'Signing in...' : 'Sign in',
                              color: kPraimaryColor,
                              width: double.infinity,
                              height: 50,
                              fontsize: 18,
                              borderRadius: BorderRadius.circular(10),
                              // onPressed: _isLoading ? null : _signIn,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpRegisterPage()),
                                  );
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: kPraimaryColor,
                                    fontFamily: kFontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
