// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_m.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DonationsM> _$donationsMSerializer = new _$DonationsMSerializer();

class _$DonationsMSerializer implements StructuredSerializer<DonationsM> {
  @override
  final Iterable<Type> types = const [DonationsM, _$DonationsM];
  @override
  final String wireName = 'DonationsM';

  @override
  Iterable<Object?> serialize(Serializers serializers, DonationsM object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(DonationM)])),
    ];

    return result;
  }

  @override
  DonationsM deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DonationsMBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DonationM)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$DonationsM extends DonationsM {
  @override
  final BuiltList<DonationM> list;

  factory _$DonationsM([void Function(DonationsMBuilder)? updates]) =>
      (new DonationsMBuilder()..update(updates)).build();

  _$DonationsM._({required this.list}) : super._() {
    BuiltValueNullFieldError.checkNotNull(list, 'DonationsM', 'list');
  }

  @override
  DonationsM rebuild(void Function(DonationsMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DonationsMBuilder toBuilder() => new DonationsMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DonationsM && list == other.list;
  }

  @override
  int get hashCode {
    return $jf($jc(0, list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DonationsM')..add('list', list))
        .toString();
  }
}

class DonationsMBuilder implements Builder<DonationsM, DonationsMBuilder> {
  _$DonationsM? _$v;

  ListBuilder<DonationM>? _list;
  ListBuilder<DonationM> get list =>
      _$this._list ??= new ListBuilder<DonationM>();
  set list(ListBuilder<DonationM>? list) => _$this._list = list;

  DonationsMBuilder() {
    DonationsM._initializeBuilder(this);
  }

  DonationsMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _list = $v.list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DonationsM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DonationsM;
  }

  @override
  void update(void Function(DonationsMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DonationsM build() {
    _$DonationsM _$result;
    try {
      _$result = _$v ?? new _$DonationsM._(list: list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DonationsM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
