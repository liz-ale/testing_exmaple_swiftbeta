//
//  ContentView.swift
//  Notas
//
//  Created by lizbeth.alejandro on 17/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var viewModel: ViewModel = .init()
    @State var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        //si una prop tiene valor false, cambiara a true y viceversa
                        showCreateNote.toggle()
                    }, label: {
                        Label("Crear nota", systemImage: "square.and.pencil")
                        //FORZAR que aparezca label e icono de boton
                            .labelStyle(TitleAndIconLabelStyle())
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                }
            }
            .navigationTitle("Notas")
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: viewModel, id: note.id, title: note.title, text: note.getText)
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: [
        //estamos inyectando una dependencia que necesita el viewmodel para funcionar
        .init(title: "swift", text: "ver youtube", createdAt: .now),
        .init(title: "kotlin", text: "codecadmy", createdAt: .now)
    ]))
}
