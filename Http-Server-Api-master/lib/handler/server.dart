import 'dart:io';
import 'package:http_server_api/api/till.dart';
import 'package:network_info_plus/network_info_plus.dart';


class Server {
  

  String? wifiIP;
  HttpServer? hServer;
  int port = 1122;
  

  Future<dynamic> getIP() async {
    wifiIP = await NetworkInfo().getWifiIP() ?? '0.0.0.0';
    return wifiIP;
  }

  openServer() async {
    hServer = await HttpServer.bind(wifiIP, port);

    await for (HttpRequest hr in hServer!) {

    //--patch checking
      if(hr.uri.path == '/till/set') {
        //
        

        //


        String? name = hr.uri.queryParameters['name'];
        String? tillid = hr.uri.queryParameters['tillid'];
        TillApi().tillSet(tillid!, name!);
        hr.response.write('Status Code: ${hr.response.statusCode}');
      }

      if (hr.uri.path == '/till/get') {
        TillApi().tillGet(hr);
      }

      if (hr.uri.path == '/till/update') {
        String? id = hr.uri.queryParameters['id'];
        String? name = hr.uri.queryParameters['name'];
        String? tillid = hr.uri.queryParameters['tillid'];
        TillApi().tillUpdate(id!, name!, tillid!);
        hr.response.write('Status Code: ${hr.response.statusCode}');
      }






      if (hr.uri.path == '/till/delete') {
        String? id = hr.uri.queryParameters['id'];
        TillApi().tillDelete(id);
        hr.response.write('Status Code: ${hr.response.statusCode}');
      }

      hr.response.close();
    }
  }

  closeServer() async {
    await hServer!.close();
  }


}
