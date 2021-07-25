//
//  RSnakeTest.swift
//  RSnakeTest
//
//  Created by Piotr Rybka on 25/07/2021.
//

import XCTest

@testable import RSnakeBattle


class SnakeViewModelTest: XCTestCase {
    
    var snakeViewModel: SnakeViewModel!
    let startingPoints = CGPoint(x: 40.0, y: 40.0)
    
    override func setUp() {
        super.setUp()
        snakeViewModel = SnakeViewModel(startSnakePosition: startingPoints)
    }
    
    override func tearDown() {
        snakeViewModel = nil
        super.tearDown()
    }

    func testSnakeStartUpValidation() throws {
        XCTAssertEqual(snakeViewModel.snakeModel.body.count, 3)
        
        var expSnakePosY: CGFloat = startingPoints.y
        for snakeBodyElemenet in snakeViewModel.snakeModel.body {
            XCTAssertEqual(snakeBodyElemenet.position.y, expSnakePosY)
            expSnakePosY += snakeViewModel.snakeModel.heigh
        }
    }
    
    func testAddBodyElementProcessWhenSnakeMovesUp() throws {
        
        var expSnakeBodyPosition:BodyPart = snakeViewModel.snakeModel.body.last!
        expSnakeBodyPosition.position.y += snakeViewModel.snakeModel.heigh
        
        snakeViewModel.addLastBodyElement(.up)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.last?.position, expSnakeBodyPosition.position)
    }
    
    func testAddBodyElementProcessWhenSnakeMovesDown() throws {
        
        var expSnakeBodyPosition:BodyPart = snakeViewModel.snakeModel.body.last!
        expSnakeBodyPosition.position.y -= snakeViewModel.snakeModel.heigh
        
        snakeViewModel.addLastBodyElement(.down)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.last?.position, expSnakeBodyPosition.position)
    }
    
    func testAddBodyElementProcessWhenSnakeMovesLeft() throws {
        
        var expSnakeBodyPosition:BodyPart = snakeViewModel.snakeModel.body.last!
        expSnakeBodyPosition.position.x -= snakeViewModel.snakeModel.width
        
        snakeViewModel.addLastBodyElement(.left)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.last?.position, expSnakeBodyPosition.position)
    }
    
    func testAddBodyElementProcessWhenSnakeMovesRight() throws {
        
        var expSnakeBodyPosition:BodyPart = snakeViewModel.snakeModel.body.last!
        expSnakeBodyPosition.position.x += snakeViewModel.snakeModel.width
        
        snakeViewModel.addLastBodyElement(.right)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.last?.position, expSnakeBodyPosition.position)
    }
    
    
    func testSnakeMovement() throws {
        
        //First go UP
        snakeViewModel.move(.up)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[0].position, CGPoint(x:40, y:20))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[1].position, CGPoint(x:40, y:40))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[2].position, CGPoint(x:40, y:60))
        
        //Next RIGHT
        snakeViewModel.move(.right)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[0].position, CGPoint(x:60, y:20))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[1].position, CGPoint(x:40, y:20))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[2].position, CGPoint(x:40, y:40))
        
        //Then DOWN
        snakeViewModel.move(.down)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[0].position, CGPoint(x:60, y:40))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[1].position, CGPoint(x:60, y:20))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[2].position, CGPoint(x:40, y:20))
        
        //Finally LEFT
        snakeViewModel.move(.left)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[0].position, CGPoint(x:40, y:40))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[1].position, CGPoint(x:60, y:40))
        
        XCTAssertEqual(snakeViewModel.snakeModel.body[2].position, CGPoint(x:60, y:20))
    }
    
    func testCollisionDetection() throws {
        
        snakeViewModel.move(.up)
        snakeViewModel.move(.down)
        
        XCTAssertTrue(snakeViewModel.isCollisionDetected == true)
    }
    
    func testGameReset() throws {
        
        snakeViewModel.addLastBodyElement(.up)
        snakeViewModel.addLastBodyElement(.up)
        snakeViewModel.addLastBodyElement(.up)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.count, 6)
        
        snakeViewModel.reset(startSnakePosition: startingPoints)
        
        XCTAssertEqual(snakeViewModel.snakeModel.body.count, 3)
        
        var expSnakePosY: CGFloat = startingPoints.y
        for snakeBodyElemenet in snakeViewModel.snakeModel.body {
            XCTAssertEqual(snakeBodyElemenet.position.y, expSnakePosY)
            expSnakePosY += snakeViewModel.snakeModel.heigh
        }
    }
}
