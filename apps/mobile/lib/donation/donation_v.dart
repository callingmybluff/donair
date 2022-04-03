import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donation_c.dart';
import 'donation_m.dart';

class DonationV extends StatelessWidget {
  const DonationV({
    Key? key,
    required DonationC controller,
  })  : donation = controller,
        super(key: key);

  final DonationC donation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: donation.stream,
      builder: (BuildContext context, AsyncSnapshot<DonationM> snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        final model = snapshot.data as DonationM;
        return Row(
          children: [
            Expanded(
              child: Text(model.amount.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: model.isGenerated
                  ? ElevatedButton(
                      child: const Text('Pay / Display invoice and receipt'),
                      onPressed: () {
                        if (model.isGenerated) launch(model.link as String);
                      },
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
