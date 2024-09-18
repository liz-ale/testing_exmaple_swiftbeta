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
    
    //array vacio cada que se cree instancia del viewmodel
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text: String) {
        let note: Note = .init(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    
    //id -> para actualizar la nota
    func updateNoteWith(id: UUID, newTitle: String, newText: String?) {
        
        //buscamos la nota dentro del array
        if let index = notes.firstIndex(where: { $0.id == id }) {
            //actualizamos nota
            let updateNote = Note(id: id, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            //añdaimos en posicion donde estaba la nota
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith(id: UUID) {
        notes.removeAll(where: { $0.id == id })
    }
}
