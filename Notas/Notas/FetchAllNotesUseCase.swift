//
//  FetchAllNotesUseCase.swift
//  Notas
//
//  Created by lizbeth.alejandro on 18/09/24.
//

import Foundation

struct FetchAllNotesUseCase {
    
    //referencia a la BD mediante abstraccion
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func fetchAll() throws -> [Note] {
        try notesDatabase.fecthAll()
    }
}
