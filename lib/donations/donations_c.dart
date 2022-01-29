import 'package:rxdart/subjects.dart';

import 'package:donair/donation/donation_c.dart';
import 'package:donair/donations/donations_m.dart';

class DonationsC {
  DonationsC({DonationsM? initial})
      : controller = BehaviorSubject.seeded(initial ?? DonationsM());
  BehaviorSubject<DonationsM> controller;
  Stream<DonationsM> get stream => controller.stream;
  DonationsM get current => controller.value;

  void addItem({required DonationC initialValue}) {
    controller.add(DonationsM.add(current, initialValue.current));
  }
}
