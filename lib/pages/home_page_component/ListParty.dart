import 'package:flutter/material.dart';

// My Own Imports
import 'package:soiree/pages/category/top_offers.dart';

class ListParty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          //Filters(),
          ItemLists(),
        ],
      ),
    );
  }
}

class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[],
    );
  }
}

class ItemLists extends StatelessWidget {
  final bestFashionList = [
    {
      'image': 'assets/best_of_fashion/best_of_fashion_1.jpg',
      'title': 'Panties',
      'offer': 'Best Collection'
    },
    {
      'image': 'assets/best_of_fashion/best_of_fashion_2.jpg',
      'title': 'Puma',
      'offer': 'Minimum 55% Off'
    },
    {
      'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
      'title': 'Quttos & X-Well',
      'offer': 'Min. 50% Off'
    },
    {
      'image': 'assets/best_of_fashion/best_of_fashion_4.jpg',
      'title': 'Nighties & Nightdresses',
      'offer': 'Starting at ₹399'
    },
    {
      'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
      'title': 'Quttos & X-Well',
      'offer': 'Min. 50% Off'
    },
    {
    'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
    'title': 'Quttos & X-Well',
    'offer': 'Min. 50% Off'
    },

    {
    'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
    'title': 'Quttos & X-Well',
    'offer': 'Min. 50% Off'
    },
    {
      'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
      'title': 'Quttos & X-Well',
      'offer': 'Min. 50% Off'
    },

    {
      'image': 'assets/best_of_fashion/best_of_fashion_3.jpg',
      'title': 'Quttos & X-Well',
      'offer': 'Min. 50% Off'
    },


  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(bestFashionDeal) {
      final item = bestFashionDeal;
      return InkWell(
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(6.0),
                height: 150.0,
                child: Image(
                  image: AssetImage(item['image']),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${item['title']}',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      '${item['offer']}',
                      style: TextStyle(
                          color: const Color(0xFF67A86B), fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopOffers(title: '${item['title']}')),
          );
        },
      );
    }

    return Column(
      children: <Widget>[
        SizedBox(
          width: width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: 460.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF18429D),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                width: width - 20.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  childAspectRatio: ((width) / 500),
                  children: List.generate(bestFashionList.length, (index) {
                    return getStructuredGridCell(bestFashionList[index]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
