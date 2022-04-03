// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DonationState _$initial = const DonationState._('initial');
const DonationState _$error = const DonationState._('error');
const DonationState _$initialized = const DonationState._('initialized');
const DonationState _$inserting = const DonationState._('inserting');
const DonationState _$inserted = const DonationState._('inserted');
const DonationState _$generated = const DonationState._('generated');

DonationState _$valueOf(String name) {
  switch (name) {
    case 'initial':
      return _$initial;
    case 'error':
      return _$error;
    case 'initialized':
      return _$initialized;
    case 'inserting':
      return _$inserting;
    case 'inserted':
      return _$inserted;
    case 'generated':
      return _$generated;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DonationState> _$values =
    new BuiltSet<DonationState>(const <DonationState>[
  _$initial,
  _$error,
  _$initialized,
  _$inserting,
  _$inserted,
  _$generated,
]);

Serializer<DonationState> _$donationStateSerializer =
    new _$DonationStateSerializer();

class _$DonationStateSerializer implements PrimitiveSerializer<DonationState> {
  @override
  final Iterable<Type> types = const <Type>[DonationState];
  @override
  final String wireName = 'DonationState';

  @override
  Object serialize(Serializers serializers, DonationState object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DonationState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DonationState.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
