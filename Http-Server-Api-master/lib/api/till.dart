import 'dart:convert';
import 'dart:io';

import 'package:http_server_api/model/till.dart';
import 'package:uuid/uuid.dart';

class TillApi{
  static List<Till> till = [];

                                   //todo login  Data

  static Map<dynamic,String> login={
    "email":"abu@gmail.com",
    "password":"123456",
  };                                     //todo loginData

  
  //till set
  tillSet(String tillid, String name) {
    Till t = Till(id: Uuid().v1(), name: name, tillid: tillid);
    till.add(t);
  }

  //till get
  tillGet(HttpRequest hr) {
    // for(int i=0;i<till.length;i++){
    //   h.response.write('${till[i].id}\t${till[i].name}\t${till[i].tillid}\n');
    // }

    hr.response.write(jsonEncode(till));
  }

  //till update
  tillUpdate(String id, String name, String tillid) {
    for (int i = 0; i < till.length; i++) {
      if (till[i].id == id) {
        till[i] = Till(id: till[i].id, name: name, tillid: tillid);
        break;
      }
    }
  }



  //todo login

  //till delete
  tillDelete(String? id) {
    for (int i = 0; i < till.length; i++) {
      if (till[i].id == id) {
        till.removeAt(i);
        break;
      }
    }
  }
}