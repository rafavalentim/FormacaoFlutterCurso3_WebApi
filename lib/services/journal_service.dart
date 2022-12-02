import 'dart:convert';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'http_interceptors.dart';

class JournalService {
  static const String url = "http://192.168.0.15:3000/";
  static const String resource = "journals/";

  //Instanciando um client para usar com o Interceptor.
  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      body: jsonJournal,
      headers: {
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  //MÉTODO ANTIGO PARA TESTAR O ENDPOINT LEARNHTTP
  // register(String content) {
  //   client.post(Uri.parse(getUrl()), body: {"content": content});
  // }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));

    if(response.statusCode != 200){
        throw Exception();
    }

    List<Journal> list =[];

    List<dynamic> listDynamic = json.decode(response.body);

    for(var jsonMap in  listDynamic){
      list.add(Journal.fromMap(jsonMap));
    }

    print(list.length);

    return list;
  }
}
