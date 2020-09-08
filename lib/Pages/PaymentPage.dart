import 'package:Wassines/styleGuide.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Text('Chose payment Method', style: kheadlineStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              children: [
                PaymentMethod(
                  icon: Icons.credit_card,
                  text: 'Credit Card',
                ),
                PaymentMethod(
                  icon: Icons.android,
                  text: 'Android Pay',
                ),
                PaymentMethod(
                  icon: Icons.money_off,
                  text: 'Paypal',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  final String text;
  final Widget page;
  final IconData icon;
  const PaymentMethod({
    Key key,
    this.text,
    this.page,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        elevation: 2,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 80,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 20, fontFamily: 'Lato'),
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
