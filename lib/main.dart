// ignore_for_file: prefer_const_declarations, prefer_const_constructors, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/post_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlogVoyage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = true;
  var posts;
  var imgUrl;

  void fetchBlogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print("No Connectivity");
      final cachedData = prefs.getString('cached_data');

      if (cachedData != null) {
        print("Cached Data Found");
        setState(() {
          _isLoading = false;
          posts = json.decode(cachedData);
        });
      }
    } else {
      final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
      final String adminSecret =
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'x-hasura-admin-secret': adminSecret,
        });

        if (response.statusCode == 200) {
          // Request successful, handle the response data here
          print('Request status code: ${response.statusCode}');
          final Map items = json.decode(response.body);
          var post = items['blogs'];
          prefs.setString('cached_data', json.encode(post));
          setState(() {
            _isLoading = false;
            posts = post;
          });
        } else {
          // Request failed
          print('Request failed with status code: ${response.statusCode}');
          print('Response data: ${response.body}');
        }
      } catch (e) {
        // Handle any errors that occurred during the request
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchBlogs();
    return Scaffold(
        appBar: AppBar(
          title: Text("BlogVoyage"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  fetchBlogs();
                })
          ],
        ),
        body: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: posts != null ? posts.length : 0,
                    itemBuilder: (context, i) {
                      final Post = posts[i];
                      final imgURL = Post['image_url'];
                      //All the below code is to fetch the image
                      // print(imgURL);
                      imgUrl = imgURL;
                      // print(imgUrl);

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return PostView(
                                    Post['title'], Post['image_url']);
                              },
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: 500.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        //check if the image is not null (length > 5) only then check imgUrl else display default img
                                        image: NetworkImage(imgUrl.toString())),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    Post["title"],
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
