//
//  UserRowView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    UserRowView(user: User(id: 1, name: "John Doe", email: "john@example.com"))
}
