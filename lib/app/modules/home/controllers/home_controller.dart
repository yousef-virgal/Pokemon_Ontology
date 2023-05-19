import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/query_response_model.dart';
import '../../../data/providers/rdf_provider.dart';



class HomeController extends GetxController {
  Rx<QueryResponse?> queryResponse = Rx(null);
  RdfProvider rdfProvider = Get.find<RdfProvider>();
  TextEditingController queryController = TextEditingController();
  List<String> columns = ["name"];
  String testQuery = "Select ?input ?name where { ?input a :Type. ?input rdfs:label ?name.}";
  Rx<String> labelText = Rx('Query');
  Rx<int?> pickedQuery = Rx(null);
  Rx<int?> noOfResults = Rx(null);
  final formKey = GlobalKey<FormState>();

  performQuery() async {
    BotToast.showLoading();
    if(formKey.currentState!.validate()){
      QueryResponse? response = await rdfProvider.sendQuery(query: queryController.text);
      if(response != null){
        setCols();
        queryResponse.value = response;
      }

      // resetQueryText();
    }
    print(queryResponse.value?.response);
    BotToast.closeAllLoading();
  }

  @override
  void onInit() async {
    super.onInit();
  }


  resetQueryText(){
    queryController.clear();
  }





  bool get noResponse => queryResponse.value == null;

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
}
