//
//  ShortcutsViewModelTests.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import Combine
import XCTest
@testable import XShortcuts

/**
 `ViewModelTests` is a subclass of XCTestCase, designed to perform automated tests on the `ViewModel` class.
 
 - Parameters:
 - sut: An optional instance of `ViewModel`, standing for 'System Under Test'.
 - cancellables: A set of AnyCancellable, used to manage memory for Combine subscriptions.
 */

final class ViewModelTests: XCTestCase {
    private var sut: ViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    /**
     Sets up the testing environment before each test method in this test case is called.
     
     This method initializes the `ViewModel` instance and sets up a Combine pipeline to test the asynchronous retrieval and filtering of shortcuts.
     
     It ensures that the ViewModel successfully retrieves and filters shortcuts, fulfilling an XCTest expectation.
     */
    
    @MainActor override func setUp() {
        super.setUp()
        
        let expectation = XCTestExpectation(description: "Array of 'Shortcut' objects returned")
        
        sut = ViewModel(service: Service())
        
        sut?.$filteredShortcuts
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { shortcuts in
                XCTAssert(shortcuts.count > 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut?.getShortcuts()
        wait(for: [expectation], timeout: 1)
    }
    
    /**
     Tears down the test environment after each test method in this test case has been called.
     
     This method deallocates the `ViewModel` instance and clears the Combine cancellables set to avoid memory leaks.
     */
    
    override func tearDown() {
        sut = nil
        cancellables = []
        super.tearDown()
    }
    
    /**
     Tests the filtering functionality of the `ViewModel`.
     
     This method verifies that applying different filter criteria to the ViewModel correctly changes the count of `filteredShortcuts`.
     It checks this behavior for multiple filter states, including `.all`, `.editing`, and `.navigation`.
     */
    @MainActor func testFiltering() {
        sut?.filter = .all
        XCTAssertEqual(sut?.filteredShortcuts.count, 34)
        sut?.filter = .editing
        XCTAssertEqual(sut?.filteredShortcuts.count, 5)
        sut?.filter = .navigation
        XCTAssertEqual(sut?.filteredShortcuts.count, 3)
    }
}
