import SwiftUI
import Security

struct SignInView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isSignedIn: Bool

    var body: some View {
        VStack {
            TextField("Enter your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Enter your password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Sign In") {
                handleSignIn()
            }
            .buttonStyle(SignInButtonStyle())
            .padding()
        }
        .padding()
        .onAppear {
                   email = UserDefaults.standard.string(forKey: "email") ?? ""
                   password = getPasswordFromKeychain(email: email) ?? ""
               }
    }

    private func getPasswordFromKeychain(email: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email,
            kSecReturnData: true
        ] as CFDictionary

        var passwordData: AnyObject?
        let status = SecItemCopyMatching(query, &passwordData)

        if status == noErr, let data = passwordData as? Data {
            return String(data: data, encoding: .utf8)
        }

        return nil
    }

    private func handleSignIn() {
        guard !email.isEmpty, !password.isEmpty else {
       
            return
        }

        UserDefaults.standard.set(email, forKey: "email")

        savePasswordToKeychain(password: password)

        isSignedIn = true
    }

    private func savePasswordToKeychain(password: String) {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email,
            kSecValueData: password.data(using: .utf8)!
        ] as CFDictionary

        SecItemDelete(keychainItem)
        SecItemAdd(keychainItem, nil)
    }
}
