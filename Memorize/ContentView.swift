//
//  ContentView.swift
//  Memorize
//
//  Created by İsmail Can Akgün on 21.11.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let emojis : [String] = ["👾", "👻", "🎃", "💣", "🪓", "🧲"]
        HStack {
            // böyle bir Range yapacaksak bu id: \.selfi koyacaksınız.
            ForEach(emojis.indices, id: \.self)  { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    // @State aslında isFaceUp'ı tuttuğu küçük hafıza parçasına yönelik bir işaretçi oluşturuyor.
    // Yani artık işaretçi değişmez, işaretçinin kendisi işaret ettiği şey değişebilir.
    // Ancak işaretçi asla değişmez.
    // Yani görünümün değişmeyeceği ancak isFaceUp'ın değiştirilebileceği gerçeğini karşılıyor. yani orada olan şey bu.
    // Gelecek hafta biraz oyun mantığına sahip olduğumuzdan @State'den kurtulacağız
    let content: String
   @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            // toggle bool durumunu true'dan false'a false'dan true'ya değiştiren yapıdır.
            isFaceUp.toggle()
        }
    }
    
}

#Preview {
    ContentView()
}
