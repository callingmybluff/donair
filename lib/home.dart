import 'package:donair/donation/donation_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:donair/sl.dart';
import 'package:donair/donation/donation_m.dart';
import 'package:donair/donations/donations_v.dart';
import 'package:donair/donations/donations_c.dart';

class Home extends StatelessWidget {
  Home({Key? key})
      : _donationsC = ServiceLocator.instance<DonationsC>(),
        super(key: key);
  final DonationsC _donationsC;

  void _generatePayment(int amount) {
    _donationsC.addItem(
      initialValue: DonationC(
        initial: DonationM.viaAmount(amount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Donations'),
      ),
      body: DonationsV(
        donationsController: _donationsC,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController amountController = TextEditingController();
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('A new donation'),
                content: TextFormField(
                  controller: amountController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (amountController.text.isNotEmpty) {
                        _generatePayment(int.parse(amountController.text));
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Donation',
        child: const Text('Donate'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
