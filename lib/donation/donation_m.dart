import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'donation_m.g.dart';

abstract class DonationM implements Built<DonationM, DonationMBuilder> {
  int get amount;
  String? get link;
  bool get isGenerated => link != null;

  DonationM._();
  factory DonationM([void Function(DonationMBuilder) updates]) = _$DonationM;
  static void _initializeBuilder(DonationMBuilder builder) =>
      builder..link = null;

  factory DonationM.viaAmount(int amount) => DonationM((b) => b
    ..amount = amount
    ..link = null);
  factory DonationM.addLink(DonationM donation, String link) =>
      donation.rebuild((b) => b..link = link);
}
