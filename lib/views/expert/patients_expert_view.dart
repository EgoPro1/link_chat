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

  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    var premiumService = PremiumService();

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
                  // future: premiumService.premiumList(_prefs.gettoken),
                  future: premiumService.premiumList(
                      _prefs.gettoken),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("ERROR"),
                      );
                    }
                    if (snapshot.hasData) {
                      var premiumList = (snapshot.data
                              as APIResponse<List<PatientResultResponse>>)
                          .data;
                      return TabBarView(
                        children: [
                          ActiveExpertView(
                            premiumList: premiumList!,
                          ),
                          PasiveExpertView()
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
