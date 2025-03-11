<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
  <h1>Online Localization - Flutter Client</h1>

  <h2>Introduction</h2>
  <p><strong>Online Localization - Flutter Client</strong> is a library that helps you integrate multilingual support into your Flutter application. It connects with the <strong>Online Localization</strong> server to load languages and translations dynamically without needing to rebuild your application.</p>
  <p>This library makes it easy to manage translations, switch languages, and customize your app’s content based on the user’s preferred language.</p>

  <h2>Features</h2>
  <ul>
    <li>Dynamically load languages and translations from the server.</li>
    <li>Add new languages or update translations without modifying or rebuilding the app.</li>
    <li>Easily integrate with your existing Flutter project.</li>
    <li>Fully compatible with the Online Localization server-side component.</li>
  </ul>

  <h2>Setup</h2>
  <p>To use the Online Localization client library in your Flutter project, follow these steps:</p>
  
  <h3>1. Add the dependency:</h3>
  <p>In your <code>pubspec.yaml</code>, add the following dependency:</p>
  <pre>
    <code>
      dependencies:
        online_localization:
              path: package\online_localization 
        flutter_localizations:
          sdk: flutter
    </code>
  </pre>

  <h3>2. Install the dependencies:</h3>
  <p>Run the following command in the terminal:</p>
  <pre>
    <code>flutter pub get</code>
  </pre>

  <h3>3. Configure the server URL:</h3>
  <p>You need to specify the base URL of your <strong>Online Localization</strong> server. This can be done in a central location in your app, for example, in a configuration class.</p>
  <pre>
    <code>
      class Configurations {
        static List<Locale> locals = [];
        static List<String> languages = [];
        static List<Uint8List?> icons = [];

        static init() {
          // Initialize your configurations here
        }

        static Future<void> getLocales({bool offline = false}) async {
          // Fetch available locales and languages from the server
        }
      }
    </code>
  </pre>

  <h3>4. Handle language change dynamically:</h3>
  <p>Your app will dynamically change the language based on user interaction. You can define a method to handle the language change.</p>

  <h2>Usage</h2>
  <p>Here’s a sample code on how to use this library in your Flutter application.</p>

  <h3>Main Application (<code>main.dart</code>):</h3>
  <pre>
    <code>
      import 'package:flutter/material.dart';
      import 'package:flutter_localizations/flutter_localizations.dart';
      import 'package:online_localization/online_localization.dart';

      void main() {
        Configurations.init();
        runApp(MyApp());
      }

      class MyApp extends StatefulWidget {
        const MyApp({super.key});

        @override
        State<MyApp> createState() => _MyAppState();
      }

      class _MyAppState extends State<MyApp> {
        Locale _locale = const Locale('en', 'US');

        void _changeLanguage(Locale locale) {
          setState(() {
            _locale = locale;
          });
        }

        @override
        void initState() {
          super.initState();
          Future.microtask(() async {
            await Configurations.getLocales(offline: true);
            setState(() {});
          });
        }

        @override
        Widget build(BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Localization',
            locale: _locale,
            supportedLocales: Configurations.locals,
            localizationsDelegates: const [
              AppOnlineLocalization(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: MyHomePage(changeLanguage: _changeLanguage),
          );
        }
      }

      class MyHomePage extends StatefulWidget {
        final Function(Locale) changeLanguage;
        const MyHomePage({super.key, required this.changeLanguage});

        @override
        State<MyHomePage> createState() => _MyHomePageState();
      }

      class _MyHomePageState extends State<MyHomePage> {
        int _counter = 0;

        void _incrementCounter() {
          setState(() {
            _counter++;
          });
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(AppLocalization.of(context).translate(Dictionary.test)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      for (int index = 0; index < Configurations.locals.length; index++)
                        ElevatedButton(
                          onPressed: () {
                            widget.changeLanguage(Configurations.locals[index]);
                          },
                          child: Row(
                            children: [
                              Text(Configurations.languages[index]),
                              Configurations.icons[index] == null
                                  ? Container()
                                  : Image.memory(Configurations.icons[index]!, width: 50, height: 50),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Text(AppLocalization.of(context).translate(Dictionary.test)),
                  Text(AppLocalization.of(context).translate(Dictionary.flutter)),
                  Text(AppLocalization.of(context).translate(Dictionary.core)),
                  Text(AppLocalization.of(context).translate(Dictionary.welcome)),
                  Text(AppLocalization.of(context).translate(Dictionary.name)),
                  Text(AppLocalization.of(context).translate(Dictionary.yhptbtmt)),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        }
      }
    </code>
  </pre>

  <h3>Explanation:</h3>
  <ul>
    <li><strong>Configurations.init()</strong>: Initializes the language settings and resources (e.g., language codes and icons).</li>
    <li><strong>_changeLanguage()</strong>: Changes the current language in the app based on user selection.</li>
    <li><strong>MaterialApp configuration</strong>: Sets the supported locales and localization delegates.</li>
    <li><strong>MyHomePage</strong>: A simple page with a counter and translation keys displayed using the dynamically loaded translations from the server.</li>
  </ul>

  <h3>Language Selection:</h3>
  <p>The language selection is displayed using a row of <code>ElevatedButton</code> widgets. Each button represents a language, and pressing it changes the language by calling the <strong>changeLanguage</strong> function.</p>

  <h2>سرور آنلاین لوکالایزیشن - فلاتر</h2>

  <h3>معرفی</h3>
  <p><strong>Online Localization - Flutter Client</strong> یک کتابخانه است که به شما کمک می‌کند تا پشتیبانی چندزبانه را در اپلیکیشن فلاتر خود پیاده‌سازی کنید. این کتابخانه به سرور <strong>Online Localization</strong> متصل می‌شود و زبان‌ها و ترجمه‌ها را به صورت پویا بارگذاری می‌کند، بدون اینکه نیاز به ساخت مجدد اپلیکیشن باشد.</p>
  <p>این کتابخانه به راحتی به شما اجازه می‌دهد ترجمه‌ها را مدیریت کنید، زبان‌ها را تغییر دهید و محتوای اپلیکیشن خود را بر اساس زبان انتخابی کاربر شخصی‌سازی کنید.</p>

  <h3>ویژگی‌ها</h3>
  <ul>
    <li>بارگذاری پویا زبان‌ها و ترجمه‌ها از سرور.</li>
    <li>افزودن زبان‌های جدید یا به‌روزرسانی ترجمه‌ها بدون تغییر یا ساخت مجدد اپلیکیشن.</li>
    <li>یکپارچگی آسان با پروژه‌های فلاتر موجود.</li>
    <li>سازگاری کامل با بخش سرور Online Localization.</li>
  </ul>

  <h3>راه‌اندازی</h3>
  <p>برای استفاده از کتابخانه کلاینت Online Localization در پروژه فلاتر خود، مراحل زیر را دنبال کنید:</p>

  <h4>1. افزودن وابستگی‌ها:</h4>
  <p>در فایل <code>pubspec.yaml</code> پروژه خود، وابستگی‌های زیر را اضافه کنید:</p>
  <pre>
    <code>
      dependencies:
        online_localization:
            path: package\online_localization
        flutter_localizations:
          sdk: flutter
    </code>
  </pre>

  <h4>2. نصب وابستگی‌ها:</h4>
  <p>دستور زیر را در ترمینال اجرا کنید:</p>
  <pre>
    <code>flutter pub get</code>
  </pre>

  <h4>3. پیکربندی URL سرور:</h4>
  <p>باید URL پایه سرور <strong>Online Localization</strong> را در تنظیمات اپلیکیشن خود مشخص کنید. این کار را می‌توانید در یک مکان مرکزی در اپلیکیشن (مثلاً یک کلاس پیکربندی) انجام دهید.</p>

  <h4>4. مدیریت تغییر زبان به‌طور پویا:</h4>
  <p>اپلیکیشن شما به‌طور پویا زبان را بر اساس تعامل کاربر تغییر می‌دهد.</p>

</body>
</html>
