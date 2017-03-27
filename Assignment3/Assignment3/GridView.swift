//
//  GridView.swift
//  Assignment3
//
//  Created by Evan Borysko on 3/27/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    //* Answer 2 BEGIN
    @IBInspectable var size : Int = 20 {
        didSet {
            setupGrid()
        }
    }
    
    
    @IBInspectable var livingColor : UIColor = UIColor.darkGray
    @IBInspectable var emptyColor : UIColor = UIColor.white
    @IBInspectable var bornColor : UIColor = UIColor.black
    @IBInspectable var diedColor : UIColor = UIColor.lightGray
    
    @IBInspectable var gridColor : UIColor = UIColor.blue
    @IBInspectable var gridWidth : CGFloat = 0.0
    
    var grid : Grid
    //* Answer 2 END
    
    func setupGrid() {
        grid  = Grid(size, size)
        // Used for seeding tests : Q3-5
        //grid  = Grid(size, size) { _,_ in arc4random_uniform(3) == 2 ? .alive : .empty }
        //print ("Grid Init: \(grid.living.count)\n\n\(grid.description)\n\n\n\n\n\n")
    }
    
    //* Answer 4 BEGIN
    func drawGrid(_ rect: CGRect){
        
        (0 ... self.size ).forEach {
            drawLine(
                start: CGPoint(x: CGFloat($0) / CGFloat(self.size) * rect.size.width, y: 0.0),
                end:   CGPoint(x: CGFloat($0) / CGFloat(self.size) * rect.size.width, y: rect.size.height)
            )
            
            drawLine(
                start: CGPoint(x: 0.0, y: CGFloat($0) / CGFloat(self.size) * rect.size.height ),
                end: CGPoint(x: rect.size.width, y: CGFloat($0) / CGFloat(self.size) * rect.size.height)
            )
        }
        
    }
    
    func drawLine(start:CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        path.lineWidth = gridWidth
        // set the draw the stroke color, looks odd w/o assignment to specific thing to draw
        gridColor.setStroke()
        path.move(to: start)
        path.addLine(to: end)
        path.stroke()
    }
    
    func drawCells(_ rect: CGRect) {
        let size = CGSize(
            width: rect.size.width / CGFloat(self.size) ,
            height: rect.size.height / CGFloat(self.size)
        )
        let base = rect.origin
        
        (0 ... self.size).forEach { i in
            (0 ... self.size).forEach { j in
                 let origin = CGPoint(
                     x: base.x + (CGFloat(j) * size.width) + 1,
                     y: base.y + (CGFloat(i) * size.height) + 1
                 )
                 let subRect = CGRect(
                     origin: origin,
                     size: CGSize(
                        width: size.width - 2,
                        height: size.height - 2
                    )
                 )
                if grid[Position(i,j)].isAlive {
                    let path = UIBezierPath(ovalIn: subRect)
                    switch grid[Position(i,j)] {
                    case .alive :  livingColor.setFill()
                    case .empty :  emptyColor.setFill()
                    case .born :   bornColor.setFill()
                    case .died :   diedColor.setFill()
                    }
                    path.fill()
                
                }
            }
        }

        
    }

    // hand to name draw, as drawRect is no long valid
    override func draw(_ rect: CGRect) {
        
        //Draw Grid
        drawGrid(rect)
        // Fill the grid with life
        drawCells(rect)
        
        
    }
    //* Answer 4 END
    
    //* Answer 5 BEGIN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    

    typealias TouchPosition = (row: Int, col: Int)
    var lastTouchedPosition: TouchPosition?
    
    func process(touches: Set<UITouch>) -> TouchPosition? {
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        
        grid[(pos.row,pos.col)] = grid[(pos.row,pos.col)].toggle( grid[(pos.row,pos.col)] )
        
        setNeedsDisplay()
        return pos
    }
    
    func convert(touch: UITouch) -> TouchPosition {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(self.size)
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(self.size)
        let position = (row: Int(row), col: Int(col))
        return position
    }
    //* Answer 5 END
    
    func nextGrid() -> Void {
        grid = grid.next()
        setNeedsDisplay()
    }
    
    
    override init(frame : CGRect) {
        grid  = Grid(size, size)
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        grid  = Grid(size, size)
        super.init(coder: aDecoder)
    }
    

}
