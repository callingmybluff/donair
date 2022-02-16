import 'package:donair/donations/donations_c.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static GetIt instance = GetIt.instance;
  static void setup() {
    instance.registerSingleton<DonationsC>(DonationsC());
  }
}
