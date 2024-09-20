//
//  ViewModelTests.swift
//  NotasTests
//
//  Created by lizbeth.alejandro on 18/09/24.
//

import XCTest
@testable import Notas

var mockDatabase: [Note] = []

//en lugar de ir  a la BD, almacenamos
struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }
}

struct FetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Note] {
        return mockDatabase
    }
}

final class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        viewModel = ViewModel(createNoteUseCase: CreateNoteUseCaseMock(), fetchAllNotesUseCase: FetchAllNotesUseCaseMock())
    }

    override func tearDownWithError() throws {
        // reseteamos lo que tenemos en mockdatabase
        mockDatabase = []
    }
    
    func testCreateNote() {
        //given
        let title = "test title"
        let text = "test text"
        
        //when
        viewModel.createNoteWith(title: title, text: text)
        
        //then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
        
    }
    
    func testCreate2Notes() {
        //comportamiento esperado: una nota haya sido insertada en la BD
        
        //given
        viewModel.createNoteWith(title: "hello 1", text: "text 1")
        viewModel.createNoteWith(title: "hello 2", text: "text 2")
        
        //when
        let note = viewModel.notes.first
        let note2 = viewModel.notes.last
        
        //then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "hello 1")
        XCTAssertEqual(note?.text, "text 1")
       
        
        XCTAssertNotNil(note2)
        XCTAssertEqual(note2?.title, "hello 2")
        XCTAssertEqual(note2?.text, "text 2")
        XCTAssertEqual(viewModel.notes.count, 2, "deberia haber dos nota")
    }
    
//    func testUpdateNote() {
//        //given
//        let title = "test title"
//        let text = "test text"
//        
//        viewModel.createNoteWith(title: title, text: text)
//        
//        //nuevos valores que simulamos se actualizaran
//        let newTitle = "new title"
//        let newText = "new text"
//        
//        //when
//        if let id = viewModel.notes.first?.id {
//            viewModel.updateNoteWith(id: id, newTitle: newTitle, newText: newText)
//            
//            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
//            XCTAssertEqual(viewModel.notes.first?.text, newText)
//        } else {
//            XCTFail("no note was created")
//        }
//    }
//    
//    func testRemoveNote() {
//        //given
//        let title = "test title"
//        let text = "test text"
//        
//        viewModel.createNoteWith(title: title, text: text)
//        
//        if let id = viewModel.notes.first?.id {
//            viewModel.removeNoteWith(id: id)
//            
//            XCTAssertTrue(viewModel.notes.isEmpty)
//        } else {
//            XCTFail("no note was created")
//        }
//    }
    
}
