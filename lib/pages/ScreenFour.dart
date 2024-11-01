import 'package:flutter/material.dart';

class ScreenFour extends StatelessWidget {
  const ScreenFour({super.key});

  @override
  Widget build(BuildContext context) {

    final Map<String, Color> compositions ={
      'Sweet Memories': const Color.fromARGB(255, 47, 128, 237),
      'A Day Dream': const Color.fromARGB(255, 3, 158, 162),
      'Mind Explore': const Color.fromARGB(255, 240, 146, 53),
    };

    return Scaffold(
      body: Center(
        child:
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 80)),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/page4img.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                child: Text(
                    "Peter Mach",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Text(
                    "Mind Deep Relax",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 25, left: 10),
                child: Text(
                    "Join the Community as we prepare over 33 days to relax and feeljoy with the mind and happnies session across the World.",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 158, 162),
                  foregroundColor: Colors.white
                ),
                  onPressed: () {},
                  child: const SizedBox(
                    height: 55,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                                Icons.play_arrow_outlined
                            ),
                          ),
                          Text(
                              "Play Next Session",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(child: Container(
                child: ListView.builder(
                    itemCount: compositions.length,
                    itemBuilder: (context, index) {

                      String itemName = compositions.keys.elementAt(index);
                      Color itemColor = compositions[itemName]!;

                      return Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(children: [
                                IconButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: itemColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  icon: const Icon(Icons.play_arrow_outlined),
                                  onPressed: () {},
                                ),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      itemName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                    const Text(
                                      "December 29 Pre-Launch",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: IconButton(onPressed: () {}, 
                                        icon: const Icon(
                                            Icons.more_horiz,
                                          size: 36,
                                          color: Colors.grey,
                                        ),
                                    ),
                                  ),
                                )
                              ],),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:
                              Divider(
                                color: Colors.grey[350],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ))
            ],
          ),
        )
      ),
    );
  }
}