import 'dart:async' show Future;
import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  String apiKey;

  Secret({required this.apiKey});

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(apiKey: json["api_key"]);
  }
}

class SecretLoader {
  Future<String> load() async {
    final keyJson = await rootBundle.loadString("assets/secrets.json");
    final keys = jsonDecode(keyJson);
    Secret secret = Secret.fromJson(keys);
    return secret.apiKey;
  }
}
