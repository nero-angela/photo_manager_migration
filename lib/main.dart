import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_migration/preload_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final assets = await loadAssets();
  runApp(MyApp(assets: assets));
}

Future<List<AssetEntity>> loadAssets() async {
  final assetPaths = await PhotoManager.getAssetPathList(onlyAll: true);
  if (assetPaths.isNotEmpty) {
    return await assetPaths[0].assetList;
  } else {
    return [];
  }
}

class MyApp extends StatefulWidget {
  MyApp({
    Key key,
    @required this.assets,
  }) : super(key: key);

  final List<AssetEntity> assets;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pageController = PreloadPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                // https://pub.dev/packages/preload_page_view
                child: PreloadPageView.builder(
                  controller: pageController,
                  preloadPagesCount: 5,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.assets.length,
                  itemBuilder: (previewContext, index) {
                    return FutureBuilder(
                      future: widget.assets[index].thumbDataWithSize(
                        MediaQuery.of(context).size.width.toInt(),
                        MediaQuery.of(context).size.height.toInt(),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(
                            snapshot.data,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 42,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 42,
                    onSelectedItemChanged: (i) {
                      pageController.jumpToPage(i % widget.assets.length);
                    },
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(widget.assets.length, (index) => Text('${index + 1}')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
