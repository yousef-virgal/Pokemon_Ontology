import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/ask_query_response_model.dart';
import '../../../data/models/query_response_model.dart';
import '../../../data/providers/rdf_provider.dart';



class HomeController extends GetxController {
  Rx<QueryResponse?> queryResponse = Rx(null);
  RdfProvider rdfProvider = Get.find<RdfProvider>();
  TextEditingController queryController = TextEditingController();
  List<String> columns = ["name"];
  String testQuery = "Select ?input ?name where { ?input a :Type. ?input rdfs:label ?name.}";
  Rx<String> labelText = Rx('Query');
  Rx<bool?> askQueryResponse = Rx(null);
  final formKey = GlobalKey<FormState>();

  performQuery() async {
    if(formKey.currentState!.validate()){
      BotToast.showLoading();
      if(checkAskQuery()){
        bool? response = await rdfProvider.askQuery(query: queryController.text);
        print("Ask Response: $response");
        resetResponse();
        askQueryResponse.value = response;
      }
      else{
        QueryResponse? response = await rdfProvider.sendQuery(query: queryController.text);
        if(response != null){
          setCols();
          resetResponse();
          queryResponse.value = response;
        }
      }


      // resetQueryText();
      BotToast.closeAllLoading();
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }


  resetQueryText(){
    queryController.clear();
  }

  resetResponse(){
    queryResponse.value = null;
    askQueryResponse.value = null;
  }





  bool get noResponse => queryResponse.value == null && askQueryResponse.value == null;

  void setCols() {
    String str = queryController.text.toLowerCase();
    String start = "?";
    String end = "where";
    if(str.isNotEmpty){
      final startIndex = str.indexOf(start);
      final endIndex = str.indexOf(end, startIndex + start.length);
      columns = str.substring(startIndex + start.length, endIndex).trim().split('?');
      print(str.substring(startIndex + start.length, endIndex).trim().split('?'));
    }

  }

  bool checkAskQuery(){
    return queryController.text.trim().toLowerCase().indexOf("ask") == 0;
  }
}
