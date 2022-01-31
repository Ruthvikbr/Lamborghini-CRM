import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/account_request_bloc.dart';
import 'package:lamborghini/model/account_request.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/screens/components/custom_button.dart';
import 'package:lamborghini/screens/components/text_component.dart';
import 'package:lamborghini/screens/components/text_field_component.dart';
import 'package:lamborghini/screens/pages/home_page.dart';
import 'package:lamborghini/services/constants/api_constants.dart';
import 'package:lamborghini/services/constants/strings.dart';
import 'package:lamborghini/services/horizontal_page_animation.dart';
import 'package:lamborghini/services/network/auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.accountRequestBloc}) : super(key: key);

  final AccountRequestBloc accountRequestBloc;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    _mobileFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBase authBase = Provider.of<AuthBase>(context, listen: false);
    return Provider<AccountRequestBloc>(
      create: (_) => AccountRequestBloc(authBase: authBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<AccountRequestBloc>(
        builder: (_, bloc, __) => SafeArea(
          child: StreamBuilder<AccountRequest>(
              stream: widget.accountRequestBloc.accountRequestStream,
              initialData: AccountRequest(),
              builder: (context, snapshot) {
                return _buildContents(context, snapshot.data);
              }),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context, AccountRequest? accountRequest) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/registration-background.png"),
              fit: BoxFit.fill,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: accountRequest!.loading
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 122,
                height: 145,
              ),
              accountRequest.loading
                  ? AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        margin: const EdgeInsets.only(left: 7),
                        child: Text(Strings.pleaseWait)),
                  ],
                ),
              )
                  : Expanded(
                child: SingleChildScrollView(
                    child: _buildForm(accountRequest, context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(AccountRequest? accountRequest, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextComponent(
          text: Strings.signUpHeader,
          textStyle: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldComponent(
          label: Strings.mobileLabel,
          textInputType: TextInputType.number,
          obscureText: false,
          accountRequest: accountRequest,
          focusNode: _mobileFocusNode,
          controller: _mobileController,
          onEditingCompleted: (accountRequest) =>
              _mobileEditingCompleted(accountRequest),
          onChanged: (mobile) => widget.accountRequestBloc.updateMobile(mobile),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldComponent(
          label: Strings.passwordLabel,
          textInputType: TextInputType.text,
          obscureText: false,
          accountRequest: accountRequest,
          focusNode: _passwordFocusNode,
          controller: _passwordController,
          onEditingCompleted: (accountRequest) => _onSubmit(accountRequest),
          onChanged: (password) =>
              widget.accountRequestBloc.updatePassword(password),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          child: TextComponent(
            text: Strings.signUpText,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Colors.white,
          borderRadius: 8,
          onPressed: () {
            _onSubmit(accountRequest);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextComponent(
          text: Strings.existingMember,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () =>
          !accountRequest!.loading ? _navigateToSignUpPage(context) : () {},
          child: TextComponent(
            text: Strings.existingAccount,
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _mobileEditingCompleted(AccountRequest? accountRequest) {
    final nextFocus = accountRequest != null &&
        accountRequest.mobileValidator.isValid(accountRequest.mobile)
        ? _passwordFocusNode
        : _mobileFocusNode;
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _onSubmit(AccountRequest? accountRequest) async {
    if (accountRequest != null && accountRequest.canSubmit) {
      SimpleResponse simpleResponse = await widget.accountRequestBloc.submit(
        accountRequest,
        ApiConstants.register,
      );
      if (simpleResponse.isSuccessful) {
        _navigateToHomePage(context);
      } else {
        _mobileController.clear();
        _passwordController.clear();
        showAlertDialog(
          context,
          Strings.invalidCredentials,
          Strings.invalidCredentialsDesc,
        );
      }
    } else {
      showAlertDialog(
        context,
        Strings.emptyCredentials,
        Strings.emptyCredentialsDesc,
      );
    }
  }

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(Strings.retry),
              )
            ],
          );
        });
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.of(context)
        .pop();
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(HorizontalPageAnimation.createRoute(const HomePage()));
  }
}
