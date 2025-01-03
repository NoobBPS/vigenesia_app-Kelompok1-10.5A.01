// ignore_for_file: file_names, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: unused_import

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti Base URL
  String baseurl =
      'http://localhost/vigenesia/'; // ganti dengan ip address kamu / tempat kamu menyimpan backend

  Future postRegister(
      String nama, String profesi, String 
      email, String password) async {
    var dio = Dio();

    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("$baseurl/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));


      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Failed To Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF13B4FF), // Ganti dengan warna yang diinginkan
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register Your Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Warna teks diatur ke hitam
                    ),
                  ),
                  SizedBox(height: 50),
                  FormBuilderTextField(
                    name: "name",
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // Border color
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // Border color when enabled
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // Border color when focused
                      ),
                      labelText: "Nama",
                      labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                      hintText: "Masukkan Nama", // Placeholder
                      hintStyle: TextStyle(color: Colors.white), // Warna placeholder diatur ke putih
                    ),
                    style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "profesi",
                    controller: profesiController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Profesi",
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Masukkan Profesi", // Placeholder
                      hintStyle: TextStyle(color: Colors.white), // Warna placeholder diatur ke putih
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "email",
                    controller:                     emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Masukkan Email", // Placeholder
                      hintStyle: TextStyle(color: Colors.white), // Warna placeholder diatur ke putih
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    obscureText: true,
                    name: "password",
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Masukkan Password", // Placeholder
                      hintStyle: TextStyle(color: Colors.white), // Warna placeholder diatur ke putih
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await postRegister(
                                nameController.text,
                                profesiController.text,
                                emailController.text,
                                passwordController.text)
                            .then((value) => {
                                  if (value != null)
                                    {
                                      setState(() {
                                        Navigator.pop(context);
                                        Flushbar(
                                          message: "Berhasil Registrasi",
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.greenAccent,
                                          flushbarPosition: FlushbarPosition.TOP,
                                          messageColor: Colors.black, // Warna pesan diatur ke hitam
                                        ).show(context);
                                      })
                                    }
                                  else if (value == null)
                                    {
                                      Flushbar(
                                        message: "Check Your Field Before Register",
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.redAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        messageColor: Colors.black, // Warna pesan diatur ke hitam
                                      ).show(context)
                                    }
                                });
                      },
                      child: Text(
                        "Daftar",
                        style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
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
