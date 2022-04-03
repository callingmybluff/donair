import 'package:donair/utils/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

import '../donation/donation_c.dart';
import 'donations_m.dart';

class DonationsC {
  DonationsC() : controller = BehaviorSubject() {
    loadFromLocal();
  }
  BehaviorSubject<DonationsM> controller;
  Stream<DonationsM> get stream => controller.stream;
  DonationsM get current => controller.value;

  LocalStorage? _storage;

  void loadFromLocal() async {
    _storage ??= await GetIt.I.getAsync<LocalStorage>();
    String? settingsString = _storage?.getData();
    // In case of empty local file, append an empty object
    if (settingsString == null) {
      controller.add(DonationsM());
    } else {
      print(settingsString);
      DonationsM localValues = DonationsM.fromJson(settingsString);
      controller.add(localValues);
    }
  }

  void addItem({required DonationC initialValue}) {
    final newModel = DonationsM.add(current, initialValue.current);
    final modelString = newModel.toJson();
    print(modelString);
    _storage?.setData(modelString);
    controller.add(newModel);
  }
}
