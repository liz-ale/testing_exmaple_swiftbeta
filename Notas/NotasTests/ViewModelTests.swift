//
//  ViewModelTests.swift
//  NotasTests
//
//  Created by lizbeth.alejandro on 18/09/24.
//

import XCTest
@testable import Notas

final class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testUpdateNote() {
        //given
        let title = "test title"
        let text = "test text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        //nuevos valores que simulamos se actualizaran
        let newTitle = "new title"
        let newText = "new text"
        
        //when
        if let id = viewModel.notes.first?.id {
            viewModel.updateNoteWith(id: id, newTitle: newTitle, newText: newText)
            
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
        } else {
            XCTFail("no note was created")
        }
    }
    
    func testRemoveNote() {
        //given
        let title = "test title"
        let text = "test text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        if let id = viewModel.notes.first?.id {
            viewModel.removeNoteWith(id: id)
            
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail("no note was created")
        }
    }
    
}
