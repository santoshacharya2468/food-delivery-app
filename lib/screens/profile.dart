import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/auth/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
          body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedInState) {
            return Container(
              height:deviceSize.height ,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  Text("Logut"),
                  IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
                    BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                    
                  }),
                  Center(child: Text(state.user.email)),
                ],
              ));
          } else {
            return Center(
              child: Container(
                height: 45.0,
                width: 200.0,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Login to continue",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
