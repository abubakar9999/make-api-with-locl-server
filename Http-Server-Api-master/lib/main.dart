import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_server_api/UI/get.dart';
import 'package:http_server_api/UI/post.dart';
import 'package:http_server_api/handler/server.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(MyApp());
}

var url='';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

  
class _MyHomePageState extends State<MyHomePage> {

  Server server=Server();
  

  bool isServerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Till Server'),
      ),
      body: Center(
        
        child: Column(
          
          children: [
            FutureBuilder(
              future: server.getIP(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }
                else {
                  url =  'http://${snapshot.data.toString()}:${server.port}/';
                  return Text(
                    'http://${snapshot.data.toString()}:${server.port}/',
                    style: const TextStyle(fontSize: 22),
                  );
                }
              },
            ),
            const Text('(ex: http://ip:port/?data=hello)'),
            Switch(
              value: isServerOn,
              onChanged: (v) async {
                setState(() {
                  
                  isServerOn = v;
                });
                if (isServerOn) {
                  await server.openServer();
                } else {
                  await server.closeServer();
                }
              },
            ),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendData(url:url)));
            }, child: Text("Send data"))
          ],
        ),
      ),
    );
  }
}