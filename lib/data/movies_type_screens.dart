import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/data/json_data.dart';
import 'package:movie_app/screens/details_movie_screen.dart';

Widget bodyOfScreens(String type, int numPage) {
  return FutureBuilder(
    future: getData(type, numPage),
    builder: (context, snapshot) {
      log(snapshot.connectionState.toString());
      log(snapshot.hasData.toString());
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 185 / 278,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        movie: snapshot.data![index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      snapshot.data![index].image,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 60,
                        width: double.infinity,
                        // margin: const EdgeInsets.fromLTRB(0, 240, 0, 0),
                        color: Colors.black.withOpacity(.5),
                        child: Text(
                          snapshot.data![index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return const Text("error");
        }
      }
      return const Text('data');
    },
  );
}
