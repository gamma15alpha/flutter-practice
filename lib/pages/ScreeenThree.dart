import 'package:flutter/material.dart';

import '../main.dart';

class MenuItem {
  final String name;
  final int price;
  final String desc;
  final String img;

  MenuItem({required this.name, required this.price, required this.desc, required this.img});
}

class ScreeenThree extends StatelessWidget {
  const ScreeenThree({super.key});

  @override
  Widget build(BuildContext context) {

    final List<MenuItem> menuItems = [
      MenuItem(
        name: 'Original Salad',
        price: 8,
        desc: 'Lovy Food',
        img: 'assets/images/salad.png',
      ),MenuItem(
        name: 'Fresh Salad',
        price: 10,
        desc: 'Cloudy Resto',
        img: 'assets/images/fresh_salad.png',
      ),
      MenuItem(
        name: 'Yummie Ice Cream',
        price: 6,
        desc: 'Circlo Resto',
        img: 'assets/images/ice_cream.png',
      ),
      MenuItem(
        name: 'Vegan Special',
        price: 11,
        desc: 'Haty Food',
        img: 'assets/images/vegan_salad.png',
      ),
      MenuItem(
        name: 'Mixed Pasta',
        price: 13,
        desc: 'Recto Food',
        img: 'assets/images/pasta.png'
      ),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 243, 253),
      body: Center(
        child:
        Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 255, 0, 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color.fromARGB(255, 255, 64, 129),
                                  size: 16,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyHomePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          const Text(
                            "Popular Menu",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFdbdde0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 255, 0, 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.sort,
                                  color: Color.fromARGB(255, 255, 64, 129),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyHomePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (context, index){
                            MenuItem item = menuItems[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: const EdgeInsets.only(right: 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          item.img,
                                          width: 75,
                                          height: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          item.desc,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          "\$${item.price}",
                                          style: const TextStyle(
                                              color: Color.fromARGB(255, 255, 64, 129),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Expanded(child:
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(20, 255, 0, 0),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: const Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.home,
                                                  color: Color.fromARGB(255, 255, 64, 129),
                                                ),
                                              ),
                                              Text(
                                                "Home",
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 255, 64, 129),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_basket,
                                              color: Color.fromARGB(255, 255, 64, 129),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.message,
                                              color: Color.fromARGB(255, 255, 64, 129),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Color.fromARGB(255, 255, 64, 129),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),

                                ],
                              ),
                            )
                          ),
                        )
                    ),
                  ),
                )
            ),
          ],
        )
      ),

    );
  }
}