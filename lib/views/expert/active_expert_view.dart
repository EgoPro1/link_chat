import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:acceso_camara/views/expert/active_result_expert_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ActiveExpertView extends StatelessWidget {
  final List<PatientResultResponse> activeDiagnosisCases;
  const ActiveExpertView({Key? key, required this.activeDiagnosisCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverStickyHeader(
              header: Container(
                height: 60.0,
                color: const Color(0xFF13AB46),
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Activos',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 12, letterSpacing: 2),
                ),
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: (4 / 2)),
                delegate: SliverChildBuilderDelegate(
                  (context, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ActiveResultExpertView(
                              resultId: this.activeDiagnosisCases[i].resultId!,
                              accuracy:
                                  this.activeDiagnosisCases[i].modelPercentage!,
                              label: this.activeDiagnosisCases[i].modelResult!,
                              imagePath:
                                  this.activeDiagnosisCases[i].pictureUrl!)));
                      // ResultExpertView(accuracy: 0.5, label: "", imagePath: "",)
                    },
                    child: GridTile(
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
                          child: Image.network(
                            this.activeDiagnosisCases[i].pictureUrl!,
                            fit: BoxFit.contain,
                            alignment: AlignmentDirectional.centerEnd,
                            errorBuilder: (context, _, __) {
                              return Image.asset(
                                'assets/imagen3x.png',
                                fit: BoxFit.contain,
                                alignment: AlignmentDirectional.centerEnd,
                              );
                            },
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                    'Información',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ])),
                      ),
                    ),
                  ),
                  childCount: this.activeDiagnosisCases.length,
                ),
              ),
            ),
          ],
        ));
  }
}
