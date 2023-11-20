import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false

    var body: some View {
        VStack {
            if isSignedIn {
                TodoListView(username: email)
            } else {
                SignInView(email: $email, password: $password, isSignedIn: $isSignedIn)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
