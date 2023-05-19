import 'package:bot_toast/bot_toast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../models/query_response_model.dart';
import 'app_provider.dart';


class RdfProvider extends AppProvider {
  Future<QueryResponse?> sendQuery({required String query}) async {
    Response<dynamic> result;
    do {
      result = await handleNetworkError(
        get(
          "/query",
          query: {
            "q": query,
          },
          contentType: 'application/form-data',
        ),
      );

    } while (await shouldRetry());
    if (!result.isOk) {
      BotToast.showText(text:result.body["error"], duration: Duration(milliseconds: 2000));
      return null;
    }

    print("Result: ${result.body}");
    return QueryResponse.fromJson(result.body);
  }


}
