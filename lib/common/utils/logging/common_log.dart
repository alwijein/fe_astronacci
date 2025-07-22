import 'dart:convert';

import 'package:flutter/material.dart';

class Log {
  static void debug(message) {
    final timeStamp = DateTime.now();
    debugPrint("$timeStamp:\t $message");
  }

  static void prettyPrintJson(String input) {
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) => Log.debug(element));
  }
}
