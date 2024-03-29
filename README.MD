# Firebase OpenAI Proxy Server
- Secure your API Key in FE clients by using Proxy Server with Authentication.
- OpenAI Proxy Server example using Firebase Cloud Functions with iOS ChatGPT App.

## Getting Started - Proxy Server
- Install firebase cli and firebase emulator.
- Navigate to openai-proxy folder.
- type `firebase init`.
- initialize your firebase project, you only need to enable `functions` and `emulator`.
- Use Typescript (nodejs) as the language.

## Getting Started - iOS App
- Provide your own bundle id in Signing & Capabilities tab (Xcode)
- Create iOS App in Firebase Dashboard project (make sure its the same project as the one you use to create the proxy server functions) using your bundleID.
- Download GoogleServices-Info.plist to your xcode project.
- Enable Authentication with Email provider in Firebase dashboard.

## Video Tutorial
Check the full video tutorial at [YouTube](https://www.youtube.com/@XCA)
