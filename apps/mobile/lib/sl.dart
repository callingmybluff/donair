import 'package:donair/utils/local_storage.dart';
import 'package:get_it/get_it.dart';

import 'donations/donations_c.dart';

class ServiceLocator {
  static GetIt instance = GetIt.instance;

  static void setup() {
    instance.registerSingletonAsync<LocalStorage>(LocalStorage.create);
    instance.registerSingleton<DonationsC>(DonationsC());
  }
}
