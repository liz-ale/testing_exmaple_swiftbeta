//
//  CreateNoteView.swift
//  Notas
//
//  Created by lizbeth.alejandro on 17/09/24.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    
    //propiedades que se actualizan
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    //poder hacer dismiss, cuando el usuario no quiera crear la nota
    
    var body: some View {
        //creamos el formulario
        //añadimos dos textfields
        NavigationStack {
            Form {
                Section {
                    //inputs del usuario
                    //cada que un user modifica la propiedad de un textfield
                    TextField("", text: $title, prompt: Text("titulo"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("texto"), axis: .vertical)
                } footer: {
                    Text("El titulo es obligatorio")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //se actualiza la nota
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("Crear nota")
                    }
                }
            }
            .navigationTitle("Nueva Nota")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
