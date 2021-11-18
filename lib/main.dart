import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:donair/donation_m.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Donair',
      home: Donations(),
    );
  }
}

class Donations extends StatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  State<Donations> createState() => _Donations();
}

class _Donations extends State<Donations> {
  _Donations() : donationsList = <DonationM>[];
  final List<DonationM> donationsList;

  void _generatePayment(int amount) {
    _makeTheDonation(amount, donationsList.length);
    setState(() {
      donationsList.add(DonationM(amount));
    });
  }

  _makeTheDonation(int amount, int donationIndex) async {
    final respose = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/donation'),
      body: jsonEncode(<String, String>{
        'amount': (amount * 100).toString(),
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    setState(() {
      donationsList[donationIndex].generated = true;
      donationsList[donationIndex].link = respose.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Donations'),
      ),
      body: Center(
        child: donationsList.isEmpty
            ? const Center(
                child: Text(
                  'Empty, so far',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  DonationM donation = donationsList[index];
                  String text = '';
                  if (donation.generated) {
                    text = donation.link;
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Text(donation.amount.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: donation.generated
                            ? ElevatedButton(
                                child: const Text('Pay'),
                                onPressed: () {
                                  if (donation.link != '') launch(text);
                                },
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ],
                  );
                },
                itemCount: donationsList.length,
              ),
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
