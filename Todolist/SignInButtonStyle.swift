import SwiftUI

struct SignInButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ? Color.accentColor.opacity(0.8) : Color.accentColor)
            .cornerRadius(8)
    }
}
