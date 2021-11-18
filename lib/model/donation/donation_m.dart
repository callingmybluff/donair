import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'donation_m.g.dart';

abstract class DonationM implements Built<DonationM, DonationMBuilder> {
  int get amount;
  String? get link;
  bool get isGenerated => link != null;

  DonationM._();
  factory DonationM([void Function(DonationMBuilder) updates]) = _$DonationM;

  factory DonationM.viaAmount(int amount) =>
      DonationM((b) => b..amount = amount);
  factory DonationM.addLink(DonationM donation, String link) =>
      donation.rebuild((b) => b..link = link);
}

/*
class DonationM {
  final int amount;
  String link;
  bool paid;
  bool generated;

  DonationM(
    this.amount, {
    this.paid = false,
    this.generated = false,
    this.link = '',
  });

  markPaid() {
    paid = true;
  }

  markGenerated(String paymentLink) {
    link = paymentLink;
    generated = true;
  }
}

*/
