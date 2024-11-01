import 'package:flatter_templates_study/main.dart';
import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 80.0)
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyHomePage())
                            );
                          },
                          child:
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                          )
                      ),
                      const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          )
                      ),
                      const Text(
                        "Organiser",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(250, 233, 236, 255),
                              foregroundColor: const Color.fromARGB(250, 122, 136, 254),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: (){
                            },
                            child:
                            const Icon(
                                Icons.more_vert,
                                size: 30,
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
              child: ClipOval(
                  child: Image.asset(
                    "assets/images/page2_user_logo.jpg",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
              ),
            ),
            const Text(
              "Albert Flores",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Text(
                            "2.368",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey[350],
                      width: 1,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Text(
                            "346",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                            "Followings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey[350],
                      width: 1,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Text(
                            "13",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          Text(
                            "Events",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child:
              Divider(
                color: Colors.grey[350],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child:
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(250, 104, 121, 255),
                                foregroundColor: const Color.fromARGB(250, 104, 121, 255),
                              ),
                              onPressed: () {},
                              child: const Padding(
                                padding:EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.group_add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Follow",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blue,
                                      width: 2
                                  )
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.message,
                                    color: Color.fromARGB(250, 104, 121, 255),
                                  ),
                                  Text(
                                    "Messages",
                                    style: TextStyle(
                                        color: Color.fromARGB(250, 104, 121, 255)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child:
              Divider(
                color: Colors.grey[350],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 42,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(250, 104, 121, 255),
                                foregroundColor: const Color.fromARGB(250, 104, 121, 255),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "About",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 42,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blue,
                                      width: 2
                                  )
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Events",
                                style: TextStyle(
                                    color: Color.fromARGB(250, 104, 121, 255)
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 42,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blue,
                                      width: 2
                                  )
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Review",
                                style: TextStyle(
                                    color: Color.fromARGB(250, 104, 121, 255)
                                ),
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                      Text(
                      "About",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 23
                      ),
                    ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'About About About About About About About About About About About About About About 11111111 adadad dada ddddddddd',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: InkWell(
                      child: Text(
                        "Read more...",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}