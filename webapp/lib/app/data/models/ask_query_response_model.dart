class AskQueryResponse {
  bool? response;
  int? status;

  AskQueryResponse({this.response, this.status});

  AskQueryResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['status'] = this.status;
    return data;
  }
}