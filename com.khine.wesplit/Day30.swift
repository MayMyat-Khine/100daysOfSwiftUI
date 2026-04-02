//
//  Day30.swift
//  com.khine.wesplit
//
//  Created by MayMK on 4/1/26.
//

import SwiftUI

struct Day30 : View {
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var usedWords : [String] = []
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showError = false
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("New Word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id : \.self){word in
                        HStack{
                            Image(systemName : "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showError){}
            message:{
                Text(errorMsg)
            }.toolbar{
                Button("Restart"){
                    startGame()
                }
            }
        }
    }
    
    func addNewWord (){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard word.count > 0 else {return}
        
        guard isOriginal(word: word) else {
            error(title: "Word used already", msg: "Be more original")
            return
        }
        guard isPossible(word: word) else {
            error(title: "Word is impossible", msg: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: word) else {
            error(title: "Word not recognized", msg: "You can't just make them up, you know!")
            return
        }
        
        guard isAllow(word: word) else {
            error(title: "Short Length", msg: "Word must be greater than 3 words")
            return
        }
        
        withAnimation{
            usedWords.insert(word, at:    0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let loadFile = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let loadString = try? String(contentsOf: loadFile, encoding:.utf8){
                 let loadArray = loadString.components(separatedBy: "\n")
                
                rootWord = loadArray.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Cannot load the start.txt file")
            
            
    }
    
    func isOriginal (word : String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible (word : String) -> Bool {
        var tempWord = newWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        return true
    }
    
    func isReal (word : String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf8.count)
        
        let missSpellingRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return missSpellingRange.location == NSNotFound
    }
    
    func error(title: String, msg : String){
        errorMsg = msg
        errorTitle = title
        showError = true
    }
    
    func isAllow (word : String) -> Bool {
        return    word.count >= 3 && word.prefix(2) != rootWord.prefix(2)
    }
}


#Preview {
    Day30()
}
