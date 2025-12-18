import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/utils/constants/routes.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';
import 'package:smartbudget/features/login/presentation/widgets/login_header.dart';
import 'package:smartbudget/features/register/presentation/widgets/register_button.dart';
import 'package:smartbudget/features/register/presentation/widgets/register_email_field.dart';
import 'package:smartbudget/features/register/presentation/widgets/register_name_field.dart';
import 'package:smartbudget/features/register/presentation/widgets/register_password_field.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      buildWhen: (_, state) =>
          state is HomeShowPasswordUpdatedState ||
          state is HomeRegisterLoadingState ||
          state is HomeRegisterSuccessState ||
          state is HomeRegisterErrorState,
      listener: (context, state) {
        if (state is HomeRegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pushReplacement<Object>(Routes.login);
        } else if (state is HomeRegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isDark = homeCubit.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const LoginHeader(),
                      verticalSpace40,
                      const RegisterNameField(),
                      verticalSpace20,
                      const RegisterEmailField(),
                      verticalSpace20,
                      const RegisterPasswordField(),
                      verticalSpace30,
                      RegisterButton(
                        formKey: formKey,
                        isLoading: state is HomeRegisterLoadingState,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
