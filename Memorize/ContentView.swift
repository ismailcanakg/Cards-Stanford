//
//  ContentView.swift
//  Memorize
//
//  Created by İsmail Can Akgün on 21.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    let emojis : [String] = ["👾", "👻", "🎃", "💣", "🪓", "💀", "🧙‍♀️", "👹", "😱", "🧟‍♂️", "☠️", "🍭"]
    @State var cardCount: Int = 4
    
    var body: some View {
        
        VStack(spacing: 30) {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    // card-CountAdjusters
    var cardCountAdjusters: some View {
        HStack(spacing: 100) {
            cardAdder
            cardRemoved
            }
            .font(.title)
            .imageScale(.medium)

    }
    
    // card-ForEach
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            // böyle bir Range yapacaksak bu id: \.selfi koyacaksınız.
            ForEach(0..<cardCount, id: \.self)  { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            
                cardCount += offset
            
        }, label: {
            Image(systemName: symbol)
                .font(.title)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    // card-Add
    var cardAdder: some View {
        
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
        
//        Button(action: {
//            if cardCount < emojis.count {
//                cardCount += 1
//            }
//        }, label: {
//            Image(systemName: "rectangle.stack.badge.plus.fill")
//                .font(.title)
//        })
    }
    
    // card-Remove
    var cardRemoved: some View {
        
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//            .foregroundColor(.red)
        
//        Button (action: {
//            if cardCount > 1 {
//                cardCount -= 1
//            }
//        }, label: {
//            Image(systemName: "rectangle.stack.badge.minus.fill").foregroundColor(.red)
//        })
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
            
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
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
