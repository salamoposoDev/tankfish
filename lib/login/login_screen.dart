import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    User user = _auth.currentUser!;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  'Selamat Datang',
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 30.sp),
                ),
                Text(
                  'Silahkan Login untuk melanjutkan',
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 24.sp),
                ),
                SizedBox(height: 40.h),
                Image.asset(
                  'lib/icons/logo_tankfis.png',
                  scale: 20.h,
                ),
                SizedBox(height: 40.h),
                Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(color: Colors.grey), // Warna border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ), // Warna border ketika fokus
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Email tidak boleh kosong";
                        }
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value!)) {
                          return "Email tidak valid";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(color: Colors.grey), // Warna border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ), // Warna border ketika fokus
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Warna latar belakang tombol
                            elevation: 5, // Tinggi shadow
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16.0), // Border radius
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(),
                          ),
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
    );
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if (userCredential.user!.uid.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Gagal"),
          content: Text("Email atau password salah. Silakan coba lagi."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
          ],
        ),
      );
      print("Login error: $e");
    }
  }
}
