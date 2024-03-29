# Firebase OpenAI Proxy Server
- Secure your API Key in FE clients by using Proxy Server with Authentication.
- OpenAI Proxy Server example using Firebase Cloud Functions with iOS ChatGPT App.

## Getting Started - Proxy Server
- Install firebase cli and firebase emulator.
- Navigate to openai-proxy folder.
- type `firebase init`.
- initialize your firebase project, you only need to enable `functions` and `emulator`.
- Use Typescript (nodejs) as the language.
- Create .env file in functions folder. It should contains `CHAT_URL=https://api.openai.com/v1/chat/completions`. If you don't want to use Google Secret Manager, you can also put your API key in here.
- To start localhost emulator. Navigate to functions folder, and type `npm run serve`

- To deploy, navigate to `openai-proxy` folder and type `firebase deploy --only functions`.

## Storing API Key (env file or Google Secret Manager)
- By default, it uses [Google Secret Manager](https://cloud.google.com/security/products/secret-manager) to store the API Key. This requires billing
- If you don't want to use this, you can put the API_KEY in .env file. Update the source code to retrieve it from `process.env.API_KEY` and remove all code that uses defineSecret to retrive API key from Google Secret Manager.

## Getting Started - iOS App
- Provide your own bundle id in Signing & Capabilities tab (Xcode)
- Create iOS App in Firebase Dashboard project (make sure its the same project as the one you use to create the proxy server functions) using your bundleID.
- Download GoogleServices-Info.plist to your xcode project.
- Enable Authentication with Email provider in Firebase dashboard.
- Provide your own proxy server URL in `ChatGPTAPI.swift`

## Video Tutorial
Check the full video tutorial at [YouTube](https://www.youtube.com/@XCA)
