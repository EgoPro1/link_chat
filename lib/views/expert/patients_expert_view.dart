import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/premium_service.dart';
import 'package:acceso_camara/views/expert/active_expert_view.dart';
import 'package:acceso_camara/views/expert/past_expert_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PatientsExpertView extends StatelessWidget {
  const PatientsExpertView({Key? key}) : super(key: key);

  TabBar get _tabBar => TabBar(
        labelStyle: TextStyle(fontSize: 12, letterSpacing: 2),
        indicator: BoxDecoration(color: const Color(0xFF13AB46)),
        tabs: [
          Tab(
            text: 'Activos',
          ),
          Tab(
            text: 'Pasados',
          ),
        ],
      );

  Future<Map<String, dynamic>> loadTabsData() async {
    final _prefs = new PreferenciasUsuario();
    var premiumService = PremiumService();
    var activeDiagnosticCases =
        await premiumService.diagnosisCases(_prefs.gettoken);
    var pastDiagnosticCases =
        await premiumService.diagnosedCases(_prefs.getidexp, _prefs.gettoken);
    return {
      "active_list": activeDiagnosticCases,
      "past_list": pastDiagnosticCases
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text('PACIENTES',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        letterSpacing: 2,
                      )),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: ColoredBox(
                      color: const Color(0xFF85F28C),
                      child: _tabBar,
                    ),
                  ),
                ),
                body: FutureBuilder(
                  future: loadTabsData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("ERROR"),
                      );
                    }
                    if (snapshot.hasData) {
                      var data = (snapshot.data as Map<String, dynamic>);
                      var activeDiagnosisCases = (data["active_list"]
                              as APIResponse<List<PatientResultResponse>>)
                          .data;
                      var pastDiagnosisCases = (data["past_list"]
                              as APIResponse<List<PatientResultResponse>>)
                          .data;
                      return TabBarView(
                        children: [
                          ActiveExpertView(
                            activeDiagnosisCases: activeDiagnosisCases!,
                          ),
                          PasiveExpertView(
                            pastDiagnosisCases: pastDiagnosisCases!,
                          )
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))));
  }
}
