import 'package:flutter/material.dart';
import 'package:gif_finder/pages/gif_page.dart';
import 'package:gif_finder/requests/gifAPI_request.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

int getCount(List data) {
    return data.length + 1;
}

Widget createGifTable(BuildContext context, AsyncSnapshot snapshot, Function setState) {
  return GridView.builder(
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: getCount(snapshot.data["data"]),
    itemBuilder: (context, index) {
      if (index < snapshot.data["data"].length) {
        return GestureDetector(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => GifPage(gifData: snapshot.data["data"][index]))
            );
          },
          onLongPress: (){
            Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
          },
        );
      } else {
        return Container(
          child: GestureDetector(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 70,
                ),
                Text(
                  'Carregar mais...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            onTap: (){
              setState((){
                offset += 19;
              });
            },
          ),
        );
      }
    },
  );
}
