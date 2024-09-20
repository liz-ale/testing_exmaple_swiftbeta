//
//  ViewModel.swift
//  Notas
//
//  Created by lizbeth.alejandro on 17/09/24.
//

import Foundation
import Observation

//cualquier cambio que se haga en notes, sera escuchado desde la vista y s emostrara la nueva info
@Observable
class ViewModel {
    var notes: [Note]
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    
    //array vacio cada que se cree instancia del viewmodel
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase()
    ) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        fetchAllNotes() //recuperando la info de la bd
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    //id -> para actualizar la nota
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        
        //buscamos la nota dentro del array
        if let index = notes.firstIndex(where: { $0.identifier == identifier }) {
            //actualizamos nota
            let updateNote = Note(identifier: identifier, title: newTitle, text: newText, createdAt: notes[index].createdAt )
            //añdaimos en posicion donde estaba la nota
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        notes.removeAll(where: { $0.identifier == identifier })
    }
}
