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

struct MojiButton: View {
    var Gitmoji: Gitmoji
    
    init(emoji: Gitmoji){
        Gitmoji = emoji
    }
    
    
    var body: some View {
        Button(action: {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(self.Gitmoji.code, forType: NSPasteboard.PasteboardType.string)
        }) {
            HStack {
                Text(Gitmoji.emoji)
                Text(Gitmoji.description)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        let emojis: GitmojiList = convertJSON()!
        
        return VStack(alignment: .center) {
            Text("😊")
            .font(.title)
            TextField(
                "Search Gitmoji",
                text: $text,
                onEditingChanged: { _ in print("changed") },
                onCommit: { print("commit") }
            )
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            List(emojis.gitmojis, id: \.code) { Gitmoji in
                MojiButton(emoji: Gitmoji)
            }
        }
        .padding(.all)
    }
    
    func convertJSON() -> (GitmojiList)? {
        let emojis: GitmojiList
        do {
            let path = Bundle.main.path(forResource: "gitmoji", ofType: "json")
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            
            let json = string.data(using: .utf8)
            let decoder = JSONDecoder()
            emojis = try decoder.decode(GitmojiList.self, from: json!)

            return emojis
        } catch {
            print("error", error)
        }
        
        return nil
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
