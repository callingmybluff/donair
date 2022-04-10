// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_m.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DonationM extends DonationM {
  @override
  final int amount;
  @override
  final String? link;

  factory _$DonationM([void Function(DonationMBuilder)? updates]) =>
      (new DonationMBuilder()..update(updates)).build();

  _$DonationM._({required this.amount, this.link}) : super._() {
    BuiltValueNullFieldError.checkNotNull(amount, 'DonationM', 'amount');
  }

  @override
  DonationM rebuild(void Function(DonationMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DonationMBuilder toBuilder() => new DonationMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DonationM && amount == other.amount && link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, amount.hashCode), link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DonationM')
          ..add('amount', amount)
          ..add('link', link))
        .toString();
  }
}

class DonationMBuilder implements Builder<DonationM, DonationMBuilder> {
  _$DonationM? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  DonationMBuilder() {
    DonationM._initializeBuilder(this);
  }

  DonationMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _link = $v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DonationM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DonationM;
  }

  @override
  void update(void Function(DonationMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DonationM build() {
    final _$result = _$v ??
        new _$DonationM._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'DonationM', 'amount'),
            link: link);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
