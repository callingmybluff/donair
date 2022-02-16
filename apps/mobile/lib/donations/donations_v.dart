import 'package:donair/donation/donation_c.dart';
import 'package:flutter/material.dart';

import 'package:donair/donation/donation_v.dart';
import 'package:donair/donations/donations_m.dart';
import 'package:donair/donations/donations_c.dart';

class DonationsV extends StatelessWidget {
  const DonationsV({
    Key? key,
    required this.donationsController,
  }) : super(key: key);
  final DonationsC donationsController;

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
            print(model);
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
