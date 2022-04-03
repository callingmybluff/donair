import 'package:donair/donation/donation_c.dart';
import 'package:donair/sl.dart';
import 'package:flutter/material.dart';

import '../donation/donation_v.dart';
import 'donations_m.dart';
import 'donations_c.dart';

class DonationsV extends StatelessWidget {
  DonationsV({
    Key? key,
  }) : super(key: key);
  final DonationsC donationsController = ServiceLocator.instance<DonationsC>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        key: const Key('streamBuilder'),
        stream: donationsController.stream,
        builder: (BuildContext context, AsyncSnapshot<DonationsM> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final model = snapshot.data as DonationsM;

          if (model.isEmpty) {
            return const Center(
              child: Text(
                'Empty, so far',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              key: const Key('builder'),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  key: Key('listTile_${index.toString()}'),
                  title: DonationV(
                    key: Key('donation_${index.toString()}'),
                    controller: DonationC(initial: model[index]),
                  ),
                );
              },
              itemCount: model.size,
            );
          }
        },
      ),
    );
  }
}
