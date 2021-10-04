import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasiveExpertView extends StatelessWidget {
  const PasiveExpertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: (4 / 2)),
              delegate: SliverChildBuilderDelegate(
                (context, i) => GridTile(
                  child: Card(
                      elevation: 0,
                      color: Colors.grey.shade300,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'assets/imagen3x.png',
                          fit: BoxFit.contain,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  footer: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF13AB46),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2,
                                          color: const Color(0xFF13AB46))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Nombre y Apellido',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: const Color(0xFF13AB46),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Información',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ])),
                    ),
                ),
                childCount: 2,
              ),
            ),
          ],
        ));
  }
}
