//
//  CreateNoteUseCase.swift
//  Notas
//
//  Created by lizbeth.alejandro on 18/09/24.
//

import Foundation

struct CreateNoteUseCase {
    
    //abstracciones en lugar de implementar protocol
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.insert(note: note)
    }
}
