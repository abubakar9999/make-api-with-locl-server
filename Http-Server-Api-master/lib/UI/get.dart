// // ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class GetData extends StatefulWidget {
  String url;
   GetData({Key? key, required this.url}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('data'),),
    body: SafeArea(child: FutureBuilder(
      future: getDate(),
      builder: (context, AsyncSnapshot<List> snapshot) {
      if (snapshot.data == null) {
        return CircularProgressIndicator();
        
      } else {
        print(snapshot.data);
        return  ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (_, i) {
        
        return Card(
          color: Colors.grey.shade200,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ExpansionTile(
            leading: Text(snapshot.data![i]['tillid'].toString()),
            title: Text(snapshot.data![i]['name'].toString()),
            subtitle: Text(snapshot.data![i]['id'].toString()),
            children: [
             Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [ ElevatedButton(onPressed: (){}, child: Text('DELETE')),
              ElevatedButton(onPressed: (){}, child: Text('EDIT')),],
             )
            ],
          ),
        );
      },
    );
        
      }
    }),
    ),
    );
    
  }
  Future<List<dynamic>> getDate() async {
    print(widget.url+'till/get');
    Uri uri = Uri.parse(widget.url+'till/get');
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        print('Data Get Success');
        List js = jsonDecode(response.body);
        return js;
      }
    } catch (err) {
      print(err);
    }
    return [];
  }
}







//   Future<List<dynamic>?> getDate() async {
//     Uri uri = Uri.parse(url);
//     try {
//       Response response = await get(uri);
//       if (response.statusCode == 200) {
//         print('Data Get Success');
//         final js = jsonDecode(response.body);
//         return js;
//       }
//     } catch (err) {
//       print(err);
//     }
