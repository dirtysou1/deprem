import 'package:flutter/material.dart';
import 'package:potbelly/routes/router.gr.dart';
import 'package:potbelly/values/values.dart';
import 'package:potbelly/widgets/custom_text_form_field.dart';
import 'package:potbelly/widgets/dark_overlay.dart';
import 'package:potbelly/widgets/potbelly_button.dart';
import 'package:potbelly/widgets/spaces.dart';
import 'package:potbelly/backend/CreateNewAccount.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
class RegisterScreen extends StatefulWidget {


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namectrl,

      emailctrl,passctrl,telctrl;



  set namectrlSet(TextEditingController){

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    telctrl = new TextEditingController();

  }



  void registerUser() async{

    var url = "https://guvendedegilim.000webhostapp.com/login_flutter/signup.php";
    var data = {
      "email":emailctrl.text,
      "tel":telctrl.text,
      "name":namectrl.text,
      "pass":passctrl.text,
    };

    var res = await http.post(url,body:data);

    if(jsonDecode(res.body) == "account already exists"){
      Fluttertoast.showToast(msg: "account exists, Please login",toastLength: Toast.LENGTH_SHORT);

    }else{

      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
      }else{
        Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: Decorations.regularDecoration,
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                child: Image.asset(
                  ImagePath.boiledEggs,
                  height: heightOfScreen,
                  width: widthOfScreen,
                  fit: BoxFit.cover,
                ),
              ),
              DarkOverLay(),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 40,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_40),
                  child: ListView(
                    children: [
                      SpaceH36(),
                      _buildProfileSelector(),
                      SpaceH16(),
                      _buildForm(),
                      SpaceH40(),
                      PotbellyButton(
                        StringConst.REGISTER,
                        onTap: ()  {AppRouter.navigator
                            .pushNamed(AppRouter.setLocationScreen);registerUser();},
                      ),
                      SpaceH40(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConst.HAVE_AN_ACCOUNT_QUESTION,
                            textAlign: TextAlign.right,
                            style: Styles.customNormalTextStyle(),
                          ),
                          SpaceW16(),
                          InkWell(
                            onTap: () => AppRouter.navigator
                                .pushReplacementNamed(AppRouter.loginScreen),
                            child: Text(
                              StringConst.LOGIN,
                              textAlign: TextAlign.left,
                              style: Styles.customNormalTextStyle(
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSelector() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.only(top: 28),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          border: Border.all(
            width: 1,
            color: Color.fromARGB(125, 0, 0, 0),
          ),
          boxShadow: [
            Shadows.secondaryShadow,
          ],
          borderRadius: BorderRadius.all(Radius.circular(76)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0),
            Center(
              child: Image.asset(
                ImagePath.personIconMedium,
                fit: BoxFit.none,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                ImagePath.uploadIcon,
                fit: BoxFit.none,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        CustomTextFormField(
          controller: namectrl,
          hasPrefixIcon: true,
          prefixIconImagePath: ImagePath.personIcon,
          hintText: StringConst.HINT_TEXT_NAME,
        ),
        SpaceH16(),
        CustomTextFormField(
          controller: emailctrl,
          hasPrefixIcon: true,
          prefixIconImagePath: ImagePath.emailIcon,
          hintText: StringConst.HINT_TEXT_EMAIL,
        ),
        SpaceH16(),
        CustomTextFormField(
          controller: telctrl,
          hasPrefixIcon: true,
          prefixIconImagePath: ImagePath.emailIcon,
          hintText: 'Phone',
        ),
        SpaceH16(),
        CustomTextFormField(
          controller:  passctrl,
          hasPrefixIcon: true,
          prefixIconImagePath: ImagePath.passwordIcon,
          hintText: StringConst.HINT_TEXT_PASSWORD,
          obscured: true,
        ),
        SpaceH16(),
        CustomTextFormField(
          controller: passctrl,
          hasPrefixIcon: true,
          prefixIconImagePath: ImagePath.passwordIcon,
          hintText: StringConst.HINT_TEXT_CONFIRM_PASSWORD,
          obscured: true,
        ),
      ],
    );
  }



}