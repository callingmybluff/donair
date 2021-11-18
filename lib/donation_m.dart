class DonationM {
  final int amount;
  String link;
  bool paid;
  bool generated;

  DonationM(
    this.amount, {
    this.paid = false,
    this.generated = false,
    this.link = '',
  });

  markPaid() {
    paid = true;
  }

  markGenerated(String paymentLink) {
    link = paymentLink;
    generated = true;
  }
}
