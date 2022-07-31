import 'package:flutter/material.dart';
import 'package:test_flutter/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Content? content;
  int page = 1;

  void previousPage() {
    page -= 1;
    Content.connectAPI(page.toString()).then((value) {
      content = value;
      setState(() {});
    });
  }

  void nextPage() {
    page += 1;
    Content.connectAPI(page.toString()).then((value) {
      content = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    Content.connectAPI(page.toString()).then((value) {
      content = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Berita Game Indonesia"),
          ),
          body: (content == null)
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: (page == 1)
                                  ? null
                                  : () {
                                      previousPage();
                                    },
                              child: const Text("< Sebelumnya"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  nextPage();
                                },
                                child: const Text("Selanjutnya >"))
                          ],
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: content!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: null,
                              child: Row(children: <Widget>[
                                Image.network(
                                  content!.data![index]["thumb"] ??
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/768px-Google_%22G%22_Logo.svg.png",
                                  width: MediaQuery.of(context).size.width / 5,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    content!.data![index]["title"] ??
                                        "Tidak ada judul",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
    );
  }
}
