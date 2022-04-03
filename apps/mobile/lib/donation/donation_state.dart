import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'donation_state.g.dart';

class DonationState extends EnumClass {

  static const DonationState  initial = _$initial,
                              error = _$error,
                              initialized = _$initialized,
                              inserting = _$inserting,
                              inserted = _$inserted,
                              generated = _$generated;

  const DonationState._(String name) : super(name);

  static BuiltSet<DonationState> get values => _$values;
  static DonationState valueOf(String name) => _$valueOf(name);
  static Serializer<DonationState> get serializer => _$donationStateSerializer;
}