//
//  UpdateNoteView.swift
//  Notas
//
//  Created by lizbeth.alejandro on 17/09/24.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let id: UUID //SABER QUE NOTA BUSCAR PARA EL NUEVO VALOR
    
    //propiedades que se actualizan
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    //poder hacer dismiss, cuando el usuario no quiera crear la nota
    
    var body: some View {
        //creamos el formulario
        //añadimos dos textfields
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("titulo"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("texto"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeNoteWith(id: id)
                dismiss()
            }, label: {
                Text("Eliminar nota")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //se actualiza la nota
                    viewModel.updateNoteWith(id: id, newTitle: title, newText: text)
                    dismiss()
                } label: {
                    Text("Guardar")
                        .bold()
                }
            }
        }
        .navigationTitle("Modificar nota")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), id: .init(), title: "Suscribete", text: "Aprende swift, blablablabalabalbla")
    }
}
