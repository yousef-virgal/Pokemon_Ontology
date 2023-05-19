import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';


class AppProvider extends GetConnect {
  final RxBool _networkUnAvailable = false.obs;
  final RxBool isDialogOpen = false.obs;

  @override
  void onInit() {
    httpClient.baseUrl = "http://127.0.0.1:5000";
    httpClient.maxAuthRetries = 1;
    httpClient.defaultContentType = 'application/form-data';
    httpClient.followRedirects = true;
    httpClient.timeout = Duration(seconds: 15);
    httpClient.addRequestModifier<dynamic>((request) => updateHeaders(request));


    ever(_networkUnAvailable, networkStatusChanged);
  }

  void networkStatusChanged(bool networkUnAvailable) {
    if (networkUnAvailable == true) {
      isDialogOpen.value = true;
      // Open the Network error dialog in case no network available
    BotToast.showText(text:"Please check your network");
    } else {
      if (isDialogOpen.value) {
        isDialogOpen.value = false;
        Get.back(); // Closes the Network Dialog
      }
    }
  }
  String? accessToken;

  FutureOr<Request<dynamic>> updateHeaders(Request<dynamic> request) async {
    request.headers['Accept'] = 'application/json';
    request.headers['X-Requested-With'] = 'XMLHttpRequest';
    // request.headers['locale'] = Get.locale?.languageCode ?? 'en';
    //update access token with value from service or provider
    String? accessToken;

    try {
      // ignore: empty_catches
    } catch (e) {
    }

    if (accessToken != null && accessToken.isNotEmpty) {
      request.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    }

    return request;
  }

  Future<Response<dynamic>> handleNetworkError(
      Future<Response<dynamic>> response) {
    response.then((value) {
      _networkUnAvailable.value = (value.hasError &&
          (value.statusCode == null ||
              value.statusCode == HttpStatus.requestTimeout));
    } // Update the Network Availability status according to error returned in response
    );
    return response;
  }

  Future<bool> shouldRetry() async {
    if (_networkUnAvailable.value == false) {
      return false; // return instantly if network is already available => should not retry
    }
    await Future.delayed(Duration(seconds: 5)); // Wait for appropriate time
    return _networkUnAvailable.value;
  }
}
