import 'package:courses_workshop/layout/home_screen.dart';
import 'package:courses_workshop/screens/forget_password/forget_password_screen.dart';
import 'package:courses_workshop/screens/login/cubit/login_cubit.dart';
import 'package:courses_workshop/screens/login/cubit/login_states.dart';
import 'package:courses_workshop/screens/register/register_screen.dart';
import 'package:courses_workshop/shared/colors/common_colors.dart';
import 'package:courses_workshop/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginStateLoading) {
          buildProgress(
            context: context,
            text: 'please wait ...',
          );
        }

        if (state is LoginStateSuccess) {
          navigateAndFinish(
            context,
            HomeScreen(),
          );
        }

        if (state is LoginStateError) {
          buildProgress(
            context: context,
            text: state.error.toString(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: quickCustomText(
                  text: "Login", fontSize: 30, color: kPrimaryTextColor),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.0,
                  end: 16.0,
                  top: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logo(),
                    defaultTextFormField(
                        title: 'email',
                        hint: 'example@google.com',
                        controller: emailController,
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                        title: 'password',
                        hint: '***************',
                        controller: passwordController,
                        type: TextInputType.visiblePassword),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        onPressed: () {
                          // navigateTo(context, LoginScreen());
                          LoginCubit.get(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('${emailController.text} Successfully'),
                          ));
                        },
                        text: 'login'),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        onPressed: () {
                          navigateToAndCloseCurrent(context, RegisterScreen());
                        },
                        text: 'sign up',
                        textColor: kPrimaryColor,
                        borderColor: kPrimaryColor,
                        backgroundColor: kPrimaryTextColor),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, ForgetPasswordScreen());
                      },
                      child: quickCustomText(
                        text: "Forget Password .. ?",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
