import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

/// ---------------------------------------------------------------------------
/// NetworkCaller
/// ---------------------------------------------------------------------------
/// Centralized network layer for the entire application.
///
/// Responsibilities:
/// - Perform GET and POST HTTP requests
/// - Attach authentication token automatically
/// - Decode API responses
/// - Convert backend responses into `NetworkResponse`
/// - Handle unauthorized (401) responses globally
///
/// IMPORTANT:
/// UI layers must NEVER directly check HTTP status codes.
/// They should ONLY rely on `NetworkResponse.isSuccess`.
/// ---------------------------------------------------------------------------
class NetworkCaller {

  /// Performs a GET request to the given [url].
  ///
  /// Returns a [NetworkResponse] that contains:
  /// - `isSuccess = true` when API status is `success`
  /// - `isSuccess = false` when API status is `fail`
  ///
  /// Automatically:
  /// - Adds authentication token
  /// - Redirects user to login on 401 Unauthorized
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      debugPrint(url);

      final Response response = await get(
        Uri.parse(url),
        headers: {
          'token': AuthControllers.accessToken,
        },
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());

      // HTTP 200 does NOT always mean business success
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        // API-level success check
        final bool success = decodedData['status'] == 'success';

        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: success,
          responseData: decodedData,
          errorMessage: success ? null : decodedData['data']?.toString(),
        );
      }

      // Unauthorized: token expired or invalid
      if (response.statusCode == 401) {
        await _redirectToLogin();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorized',
        );
      }

      // Any other unexpected HTTP status
      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: 'Unexpected server response',
      );
    } catch (e) {
      // Network error, parsing error, or unexpected exception
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Performs a POST request to the given [url] with optional JSON [body].
  ///
  /// - Encodes request body as JSON
  /// - Checks API-level `status` field
  /// - Returns a consistent `NetworkResponse`
  static Future<NetworkResponse> postRequest(
      String url, {
        Map<String, dynamic>? body,
      }) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());

      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthControllers.accessToken,
        },
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        final bool success = decodedData['status'] == 'success';

        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: success,
          responseData: decodedData,
          errorMessage: success ? null : decodedData['data']?.toString(),
        );
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: 'Request failed',
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Clears authentication data and redirects user to Sign In screen.
  ///
  /// Called automatically when API returns HTTP 401.
  /// This ensures secure logout across the entire app.
  static Future<void> _redirectToLogin() async {
    await AuthControllers.clearAllData();

    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
          (route) => false,
    );
  }
}
