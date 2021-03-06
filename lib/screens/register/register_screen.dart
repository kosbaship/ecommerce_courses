import 'package:courses_workshop/layout/cubit/home_cubit.dart';
import 'package:courses_workshop/screens/forget_password/forget_password_screen.dart';
import 'package:courses_workshop/screens/login/login_screen.dart';
import 'package:courses_workshop/screens/register/cubit/register_cubit.dart';
import 'package:courses_workshop/screens/register/cubit/register_states.dart';
import 'package:courses_workshop/shared/colors/common_colors.dart';
import 'package:courses_workshop/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterStateLoading) {
          buildProgressDialog(
            context: context,
            text: 'please wait ...',
          );
        }

        if (state is RegisterStateSuccess) {
          // close the progress dialog in the last state
          Navigator.pop(context);
          HomeCubit.get(context).changeIndex(1);
          navigateAndFinish(
            context,
            LoginScreen(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
        }

        if (state is RegisterStateError) {
          // close the progress dialog in the last state
          Navigator.pop(context);
          buildProgressDialog(
            context: context,
            text: "This account is already exist",
            error: true,
          );
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 20.0,
                end: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  writeQuickText(
                    text: "Sign up",
                    fontSize: 28.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  buildDefaultTextField(
                      title: 'First name',
                      hint: 'Sarah',
                      controller: firstNameController,
                      type: TextInputType.name),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildDefaultTextField(
                      title: 'Last name',
                      hint: 'Smith',
                      controller: lastNameController,
                      type: TextInputType.name),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildDefaultTextField(
                      title: 'Email',
                      hint: 'Sarahsmith@gmail.com',
                      controller: emailController,
                      type: TextInputType.emailAddress),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildDefaultTextField(
                      title: 'Password',
                      hint: '***************',
                      controller: passwordController,
                      isPassword: true,
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildDefaultTextField(
                      title: 'City',
                      hint: 'Aswan',
                      controller: cityController,
                      type: TextInputType.name),
                  SizedBox(
                    height: 40.0,
                  ),
                  buildDefaultButton(
                      onPressed: () {
                        // save data for validation
                        String first = firstNameController.text;
                        String last = lastNameController.text;
                        String email = emailController.text;
                        String password = passwordController.text;
                        String city = cityController.text;

                        // checks if any field empty
                        if (first.isEmpty ||
                            last.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            city.isEmpty) {
                          // show toast
                          showToast(
                              message: "please enter a valid data",
                              error: true);
                        } else {
                          // register the user
                          RegisterCubit.get(context).register(
                            first: first,
                            last: last,
                            email: email,
                            password: password,
                            city: city,
                          );
                        }
                      },
                      text: 'sign up'),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildDefaultButton(
                      onPressed: () {
                        navigateToReplaceMe(context, LoginScreen());
                      },
                      text: 'login',
                      textColor: kLightishPurpleColor,
                      borderColor: kLightishPurpleColor,
                      backgroundColor: kWhiteColor),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, ForgetPasswordScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      child: writeQuickText(
                        text: "Forget your password .. ?",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
