import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_server_api/UI/get.dart';

class SendData extends StatefulWidget {
  String url;
  SendData({Key? key, required this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SendDataState();
  }
}

class SendDataState extends State<SendData> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Get'),
      ),
      body: Column(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Enter name"),
                controller: name,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Enter E-mail"),
                controller: email,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Enter password"),
                controller: password,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendData(name.text, password.text);
                    name.clear();
                    password.clear();
                  },
                  child: Text("submit"))
            ],
          ))
        ],
      ),
    );
  }

  //todo  -------------LogIn API-----------

  Future<void> logIn() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      var _url = "";

      var _respons = await http.post(Uri.parse(_url),
          body: ({
            //todo--- body part---
            "name": name.text,
            "email": email.text,
            "password": password.text,
          }));

      if (_respons.statusCode == 201) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GetData(url: widget.url)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something Worng")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Fill this Feild")),
      );
    }
  }

  Future sendData(String name, String tillid) async {
    String url = '${widget.url}till/set?name=$name&tillid=$tillid';

    Uri uri = Uri.parse(url);
    HttpClient request = HttpClient();
    try {
      http.Response response = await http.post(uri,
          body: jsonEncode({'name': name, 'tillid': tillid}));
      print(response.statusCode);

      if (response.statusCode == 200) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GetData(url: widget.url)));
        print('Data Get Success');
        final js = jsonDecode(response.body);
        return js;
      }
    } catch (err) {
      print(err);
    }
  }
}
