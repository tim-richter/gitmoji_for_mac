//
//  ContentView.swift
//  gitmoji
//
//  Created by Tim Richter on 27.05.20.
//  Copyright © 2020 Tim Richter. All rights reserved.
//

import SwiftUI

struct Gitmoji: Codable {
    let emoji: String
    let entity: String?
    let code: String
    let description: String
    let name: String
}

struct GitmojiList: Codable {
    let gitmojis: [Gitmoji]
}

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        let emojis: GitmojiList
        do {
            let path = Bundle.main.path(forResource: "gitmoji", ofType: "json")
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            
            let json = string.data(using: .utf8)
            let decoder = JSONDecoder()
            emojis = try decoder.decode(GitmojiList.self, from: json!)

            print(emojis.gitmojis.count)
        } catch {
            print("error", error)
        }
        
        
        return VStack {
            TextField(
                "Search for Emoji",
                text: $text,
                onEditingChanged: { _ in print("changed") },
                onCommit: { print("commit") }
            )
            Text("😊")
                .font(.title)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
