//
//  NuclearCodesTests.swift
//  NuclearCodesTests
//
//  Created by Amit Samant on 24/05/23.
//

import XCTest
@testable import NuclearCodes

final class NuclearCodesTests: XCTestCase {
    
    var profileStore: ProfileStore!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        profileStore = ProfileStore()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        profileStore = nil
    }
    
    func testAddProfile() {
        let profile = Profile(name: "John")
        
        profileStore.add(profile)
        
        XCTAssertEqual(profileStore.profiles.count, 1)
        XCTAssertEqual(profileStore.profiles.first, profile)
    }
    
    func testDeleteProfile() {
        let profile = Profile(name: "Jane")
        profileStore.add(profile)
        
        profileStore.delete(profile)
        
        XCTAssertEqual(profileStore.profiles.count, 0)
        XCTAssertNil(profileStore.selectedProfile)
    }
    
    func testSelectProfile() {
        let profile1 = Profile(name: "John")
        let profile2 = Profile(name: "Jane")
        profileStore.add(profile1)
        profileStore.add(profile2)
        
        profileStore.selectedProfile = profile2
        
        XCTAssertEqual(profileStore.selectedProfile, profile2)
    }
    
}
