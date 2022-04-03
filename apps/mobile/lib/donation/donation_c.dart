import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

import 'donation_state.dart';
import 'donation_m.dart';

class DonationC {
  DonationC({DonationM? initial})
      : controller = BehaviorSubject.seeded(initial ?? DonationM()) {
    _generateLink();
  }
  final BehaviorSubject<DonationM> controller;
  Stream<DonationM> get stream => controller.stream;
  DonationM get current => controller.value;

  checkState() async {
    if (current.isGenerated) return;

    final response = await http.get(Uri.parse('${current.id}/state'));
    final Map<String, dynamic> resJSON = jsonDecode(response.body);
    //if (DonationState. resJSON[''])
  }

  _generateLink() async {
    if (current.isGenerated) return;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/donation'),
        body: jsonEncode(<String, String>{
          'amount': (current.amount * 100).toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final Map<String, dynamic> resJSON = jsonDecode(response.body);
      controller.add(response.statusCode == 201
          ? DonationM.insert(current, resJSON['id'])
          : DonationM.updateState(current, DonationState.error));
    } catch (e) {
      if (e is SocketException) print(e.toString());
    }
  }
}
