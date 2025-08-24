import 'dart:convert';
import 'package:finance_bot/api_key.dart';
import 'package:http/http.dart' as http;

Future<String> getOpenRouterResponse(String salary, String expense) async {
  final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

  final headers = {
    "Authorization": "Bearer $apiKey",
    "Content-Type": "application/json",
  };

  final body = jsonEncode({
    "model": "google/gemini-2.0-flash-exp:free", // AI model
    "max_tokens": 1000, // Maximum number of tokens in the response
    "messages": [
      {
        "role": "system",
        "content": "You are a financial advisor giving short, practical tips."
      },
      {
        "role": "user",
        "content":
        "My yearly salary is $salary and my yearly expenses are $expense. Suggest a plan to improve my financial growth."
      }
    ],
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data["choices"][0]["message"]["content"];
  } else {
    return "Error: ${response.statusCode}";
  }
}
