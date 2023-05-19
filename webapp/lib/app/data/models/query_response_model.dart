class QueryResponse {
  List<List<String>>? response;
  int? status;

  QueryResponse({this.response, this.status});

  QueryResponse.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <List<String>>[];
      json['response'].forEach((v)
      {
        List<String> innerList = [];
        v.forEach((element)=>innerList.add(element));
        response!.add(innerList);
      }
      );
    }
    status = json['status'];
  }

}

