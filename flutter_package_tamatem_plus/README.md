<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

RESTful integrates of Tamatem Plus.

## Features

1. Implemented RESTful APIs for TamatemPlus:

    1. Launch browser to TamatemPlus for authorization
    1. Obtain the Token
    1. Connect TamatemPlus
    1. Query inventory items
    1. Get GamePlayer info
    1. Redeem inventory items
    1. Logout



## Getting started

```bash
flutter pub add tamatem_plus(TODO)
```

## Usage

1. Add ".env" file in the root of App project:

```
TAMATEM_DOMAIN={TAMATEM_DOMAIN}
TAMATEM_CLIENT_ID={TAMATEM_CLIENT_ID}
TAMATEM_CUSTOM_SCHEME={TAMATEM_CUSTOM_SCHEME}
TAMATEM_GAME_STORE={TAMATEM_GAME_STORE}
```

TAMATEM_CUSTOM_SCHEME is the deeplink scheme of the application: 
```
{companyname}-{gamename}://{companyname}
```

Based on the relevant information provided, TamatemPlus provides the following fields:

TAMATEM_DOMAIN is the API domain name, for example, https://stg-be.tamatemplus.com/

TAMATEM_CLIENT_ID is the application's ID

TAMATEM_GAME_STORE is a game store link configured by game manufacturer

---

then included asset with your application,

``` yaml
flutter:
  assets:
    - .env
```

2. Init the plugin at beginning of you app launch:
``` dart
void main() async {
  await TamatemPlusPlugin.init();

  runApp(const MyApp());
}
```

3. Embed `TamatemButton` in the layout, then customize button if needed.
``` dart
TamatemButton(
    child: Text(
        'Launch tamatem',
        style: TextStyle(color: Colors.red),
    ),
)
```


## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

## License

   Copyright 2023 kuloud

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.