

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final int price;
  PaymentPage({Key? key, required this.price}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController amtController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    amtController.text = widget.price.toString();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _HandlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerPaymentError);
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, _handlerPaymentExternalWallent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _HandlerPaymentSuccess() {
    print("payment Success");
  }

  void _handlerPaymentError() {
    print("Paymenr Failed");
  }

  void _handlerPaymentExternalWallent() {
    print("External Wallent Error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Payment"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Payment Here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: amtController,
                          decoration: InputDecoration(
                            labelText: "Enter Amount",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the amount";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the Phone Number";
                            } else if (value.length != 10) {
                              return "Please enter valid Phone number";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            _formKey.currentState!.save();

                            var options = {
                              "key": "rzp_test_DZ0in0yGOD5Ija",
                              "amount": num.parse(amtController.text) * 100,
                              "name": "Coffie shop",
                              "description": "Payment for our coffee",
                              "prefill": {
                                "contact": phoneNumberController.text,
                                "email": emailController.text,
                              },
                              "external": {
                                "wallets": ["paytm"]
                              }
                            };
                            try {
                              _razorpay.open(options);
                            } catch (e) {
                              print("Error: $e");
                              // Handle error gracefully, show a dialog, or log it for debugging.
                            }
                          },
                          child: Text("Pay"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
