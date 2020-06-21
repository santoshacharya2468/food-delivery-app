
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodsNepal/models/user.dart';

import '../../conf.dart';
abstract class AuthEvents{}
class AuthLoginEvent extends AuthEvents{
 final  User user;
  AuthLoginEvent({this.user});
}
class InitializeAuth extends AuthEvents{}
class AuthLogoutEvent extends AuthEvents{}

abstract class AuthState{}
class AuthNotLoggedInState extends AuthState{}
class AuthLoggedInState extends AuthState{
  final User user;
  AuthLoggedInState({this.user});
}
class AuthFailedState extends AuthState{
  final String message;
  AuthFailedState({this.message});
}
class AuhtTryingState extends AuthState{}
class AuthBloc extends Bloc<AuthEvents,AuthState>{
  User user;
  FlutterSecureStorage storage=FlutterSecureStorage();
  @override
  AuthState get initialState => AuthNotLoggedInState();
  @override
  Stream<AuthState> mapEventToState(AuthEvents event)async* {
    if(event is InitializeAuth){
       //fetch user from db
      
      var email=await storage.read(key: "email");
      if(email==null){
        AuthNotLoggedInState();
      }
      else{
        user=User();
        user.email=email;
        user.name=await storage.read(key: "name");
        user.token=await storage.read(key: "token");
        yield AuthLoggedInState(user: user);
      }
     
    }
    else if(event is AuthLogoutEvent){
      yield AuthNotLoggedInState();
      try{
      await storage.delete(key: "email");
      await storage.delete(key: "token");
      await storage.delete(key: "name");
      }
      catch(e){
        

      }

    }
    else if(event is AuthLoginEvent){
      user=event.user;
    //  yield AuthLoggedInState(user: user);
        yield AuhtTryingState();
        
        //send http request for login
          Dio dio = Dio(BaseOptions(headers: {
          "apikey": apiKey,
        }, validateStatus: (status) => true, baseUrl: baseUrl));
        //make http request to server
        try {
          var response = await dio.post("account/login",data: {"email":event.user.email,"password":event.user.password});
          if (response.statusCode == 200) {
             FlutterSecureStorage storage=FlutterSecureStorage();
             user.token=response.data['token'];
             user.email=event.user.email;
             yield AuthLoggedInState(user: user);
             await storage.write(key: "email", value: event.user.email);
             await storage.write(key: "token", value: user.token);
            //  user.name=event.password;
          } else if(response.statusCode==401) {
            yield AuthFailedState(message:response.data['message']);
            //yield ProductLoadingErrorState();
          }
          else{
            yield AuthFailedState(message:"Server Error");


          }
        } catch (e) {
          yield AuthFailedState(message:"Internet Error");

        }

    }
  

  }

}
