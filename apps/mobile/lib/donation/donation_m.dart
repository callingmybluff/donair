import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'donation_state.dart';
import '../utils/serializers.dart';

part 'donation_m.g.dart';

abstract class DonationM implements Built<DonationM, DonationMBuilder> {
  int get amount;
  String? get link;
  String? get id;
  bool get isGenerated => state == DonationState.generated;
  DonationState get state;

  DonationM._();
  factory DonationM([void Function(DonationMBuilder) updates]) = _$DonationM;
  static void _initializeBuilder(DonationMBuilder builder) => builder
    ..link = null
    ..state = DonationState.initial;

  factory DonationM.viaAmount(int amount) => DonationM((b) => b
    ..amount = amount
    ..link = null);
  factory DonationM.addLink(DonationM donation, String link) =>
      donation.rebuild((b) => b..link = link);
  factory DonationM.insert(DonationM donation, String id) =>
      donation.rebuild((b) => b
        ..id = id
        ..state = DonationState.inserted);
  factory DonationM.updateState(DonationM donation, DonationState newState) =>
      donation.rebuild((b) => b..state = newState);

  String toJson() {
    return json.encode(serializers.serializeWith(DonationM.serializer, this));
  }

  static DonationM fromJson(String jsonString) {
    return serializers.deserializeWith(
        DonationM.serializer, json.decode(jsonString))!;
  }

  static Serializer<DonationM> get serializer => _$donationMSerializer;
}
