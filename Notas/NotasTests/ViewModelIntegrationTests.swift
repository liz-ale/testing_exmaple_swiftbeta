//
//  ViewModelIntegrationTests.swift
//  NotasTests
//
//  Created by lizbeth.alejandro on 18/09/24.
//

import XCTest
@testable import Notas

@MainActor
final class ViewModelIntegrationTests: XCTestCase {
    
    //system under test
    var sut: ViewModel!

    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotestUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase,
                        fetchAllNotesUseCase: fetchAllNotestUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote() {
        //comportamiento esperado: una nota haya sido insertada en la BD
        
        //given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        
        //when
        let note = sut.notes.first
        
        //then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "hello 1")
        XCTAssertEqual(note?.text, "text 1")
        XCTAssertEqual(sut.notes.count, 1, "deberia haber una nota")
    }
    
    func testCreateTwoNotes() {
        //comportamiento esperado: una nota haya sido insertada en la BD
        
        //given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        sut.createNoteWith(title: "hello 2", text: "text 2")
        
        //when
        let note = sut.notes.first
        let note2 = sut.notes.last
        
        //then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "hello 1")
        XCTAssertEqual(note?.text, "text 1")
       
        
        XCTAssertNotNil(note2)
        XCTAssertEqual(note2?.title, "hello 2")
        XCTAssertEqual(note2?.text, "text 2")
        XCTAssertEqual(sut.notes.count, 2, "deberia haber dos nota")
    }
    
    func testFetchAllNotes() {
        //given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        sut.createNoteWith(title: "hello 2", text: "text 2")
        
        //when
        let note = sut.notes[0]
        let note2 = sut.notes[1]
        
        //then
        XCTAssertEqual(sut.notes.count, 2, "deberia haber 2 notas")
        XCTAssertEqual(note.title, "hello 1")
        XCTAssertEqual(note.text, "text 1")
        XCTAssertEqual(note2.title, "hello 2")
        XCTAssertEqual(note2.text, "text 2")
    }
}
