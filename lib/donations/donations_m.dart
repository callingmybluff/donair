import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'package:donair/donation/donation_m.dart';

part 'donations_m.g.dart';

abstract class DonationsM implements Built<DonationsM, DonationsMBuilder> {
  BuiltList<DonationM> get list;
  bool get isEmpty => list.isEmpty;
  int get size => list.length;
  DonationM operator [](int index) => list[index];

  DonationsM._();
  factory DonationsM([void Function(DonationsMBuilder) updates]) = _$DonationsM;
  static void _initializeBuilder(DonationsMBuilder builder) =>
      builder..list = ListBuilder();
  factory DonationsM.add(DonationsM model, DonationM newDonation) =>
      model.rebuild((b) => b..list.add(newDonation));
}
