import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rxdart/subjects.dart';

import 'package:donair/donation/donation_m.dart';

class DonationC {
  DonationC({DonationM? initial})
      : controller = BehaviorSubject.seeded(initial ?? DonationM()) {
    _generateLink();
  }
  final BehaviorSubject<DonationM> controller;
  Stream<DonationM> get stream => controller.stream;
  DonationM get current => controller.value;

  _generateLink() async {
    if (current.isGenerated) return;

    final respose = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/donation'),
      body: jsonEncode(<String, String>{
        'amount': (current.amount * 100).toString(),
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    controller.add(DonationM.addLink(current, respose.body));
  }
}
