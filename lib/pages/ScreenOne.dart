import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 158, 162),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 20.0)
            ),
            const Column(
              children: [
                Text(
                  'Medinow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,

                  ),
                ),
                Text(
                  'Meditate With Us!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed:(){},
                            child:const
                            Text(
                              "Sign in with Apple",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                        ),
                      )
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child:
                        ElevatedButton(
                            onPressed:(){},
                            child:const
                            Text(
                              "Continue in with Email or Phone",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                        ),
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                InkWell(
                  onTap: (){},
                  child:
                  const Text(
                    "Continue with Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child:
              Image.asset(
                  fit: BoxFit.contain,
                  'assets/images/page1Img.png'
              ),
            )
          ],
        ),
      ),
    );
  }
}