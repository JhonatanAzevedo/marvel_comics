import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.tryAgain});

  final Function() tryAgain;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Image.asset('assets/images/alert_error.png'),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Falha na Operação.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'Tente novamente.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: tryAgain,
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Text(
                    'Tentar\nnovamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60.0)
          ],
        ),
      ),
    );
  }
}
