//
//  RocketsListTests.swift
//  RocketsListTests
//
//  Created by Nadezhda Zenkova on 14.09.2021.
//

import XCTest
@testable import RocketsList

class RocketsListTests: XCTestCase {
    let rocketsListVC = RocketsListViewController()
    var networkService: NetworkService!
    
    var session: URLSession!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        super.tearDown()
        
    }   
    
    
    override func setUpWithError() throws {
        super.setUp()
        session = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        session = nil
        super.tearDown()
    }
    
    func testAPICall() throws {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = session.dataTask(with: URL(string: networkService.defaultAPIstringURL)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testLinksHasValues() {
        let linkPatch = Links(patch: Patch(small: URL(string: networkService.defaultAPIstringURL), large: nil), reddit: nil, flickr: nil, presskit: nil, webcast: nil, youtube: nil, article: nil, wikipedia: nil)
        let linkReddit = Links(patch: nil, reddit: Reddit(compaign: URL(string: networkService.defaultAPIstringURL), launch: nil, media: nil, recovery: nil), flickr: nil, presskit: nil, webcast: nil, youtube: nil, article: nil, wikipedia: nil)
        let linkFlickr = Links(patch: nil, reddit: nil, flickr: Flickr(small: [URL(string: networkService.defaultAPIstringURL)!], original: nil), presskit: nil, webcast: nil, youtube: nil, article: nil, wikipedia: nil)
        
        let linkPresskit = Links(patch: nil, reddit: nil, flickr: nil, presskit: URL(string: networkService.defaultAPIstringURL), webcast: nil, youtube: nil, article: nil, wikipedia: nil)
        let linkWebcast = Links(patch: nil, reddit: nil, flickr: nil, presskit: nil, webcast: URL(string: networkService.defaultAPIstringURL), youtube: nil, article: nil, wikipedia: nil)
        let linkYoutube = Links(patch: nil, reddit: nil, flickr: nil, presskit: nil, webcast: nil, youtube: URL(string: networkService.defaultAPIstringURL), article: nil, wikipedia: nil)
        let linkArticle = Links(patch: nil, reddit: nil, flickr: nil, presskit: nil, webcast: nil, youtube: nil, article: URL(string: networkService.defaultAPIstringURL), wikipedia: nil)
        let linkWikipedia = Links(patch: nil, reddit: nil, flickr: nil, presskit: nil, webcast: nil, youtube: nil, article: nil, wikipedia: URL(string: networkService.defaultAPIstringURL))
        let linksMissing = Links(patch: nil, reddit: nil, flickr: nil, presskit: nil, webcast: nil, youtube: nil, article: nil, wikipedia: nil)
        XCTAssertTrue(linkPatch.hasAnyValues())
        XCTAssertTrue(linkReddit.hasAnyValues())
        XCTAssertTrue(linkFlickr.hasAnyValues())
        XCTAssertTrue(linkPresskit.hasAnyValues())
        XCTAssertTrue(linkWebcast.hasAnyValues())
        XCTAssertTrue(linkYoutube.hasAnyValues())
        XCTAssertTrue(linkArticle.hasAnyValues())
        XCTAssertTrue(linkWikipedia.hasAnyValues())
        XCTAssertFalse(linksMissing.hasAnyValues())
    }
    
    func testTabBarControllers() {
        let rocketsVC = RocketsListViewController()
        let launchesVC = LaunchesViewController()
        let launchPadsVC = LaunchpadsViewController()
        
        XCTAssertNotNil(rocketsVC)
        XCTAssertNotNil(launchesVC)
        XCTAssertNotNil(launchPadsVC)
    }

}
