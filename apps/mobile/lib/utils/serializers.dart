import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import '../donation/donation_m.dart';
import '../donation/donation_state.dart';
import '../donations/donations_m.dart';

part 'serializers.g.dart';

@SerializersFor([
  DonationState,
  DonationM,
  DonationsM,
])

final Serializers serializers = _$serializers;