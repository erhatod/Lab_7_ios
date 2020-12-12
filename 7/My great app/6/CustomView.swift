//
//  CustomView.swift
//  My great app
//
//  Created by Oleksii Afonin on 06.12.2020.
//

import UIKit

class CustomView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var drapDiagram: Bool = false {
        didSet
        {
            draw(self.frame)
        }
    }
    
    private var zeroPoint: CGPoint {
        CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    
    private var scaleFactor: CGFloat {
        20.0
    }
    
    private var yExp: Bool {
        return true
    }
    
    private func drawCoordinateSystem() {
        if true {
            let path = UIBezierPath()
            
            let e = Darwin.M_E
            
            if !yExp {
                for i in -6...6 {
                    path.move(to: CGPoint(x: self.bounds.minX + 10, y: zeroPoint.y - CGFloat(i) * scaleFactor))
                    path.addLine(to: CGPoint(x: self.bounds.maxX - 10, y: zeroPoint.y - CGFloat(i) * scaleFactor))
                }
            } else {
                
                for i in 0...6 {
                    path.move(to: CGPoint(x: self.bounds.minX + 10, y: zeroPoint.y - CGFloat(pow(e, Double(i))) * scaleFactor))
                    path.addLine(to: CGPoint(x: self.bounds.maxX - 10, y: zeroPoint.y - CGFloat(pow(e, Double(i))) * scaleFactor))
                    
                    path.move(to: CGPoint(x: self.bounds.minX + 10, y: zeroPoint.y + CGFloat(pow(e, Double(i))) * scaleFactor))
                    path.addLine(to: CGPoint(x: self.bounds.maxX - 10, y: zeroPoint.y + CGFloat(pow(e, Double(i))) * scaleFactor))
                }
            }
            
            for i in -6...6 {
                path.move(to: CGPoint(x: zeroPoint.x - CGFloat(i) * scaleFactor, y: self.bounds.maxY - 10))
                path.addLine(to: CGPoint(x: zeroPoint.x - CGFloat(i) * scaleFactor, y: self.bounds.minY + 10))
            }
            
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.name = "CustomDrawinglayer"
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.fillColor = .none
            shapeLayer.lineWidth = 0.1
            
            self.layer.addSublayer(shapeLayer)
        }
        let path = UIBezierPath()
        
        
        path.move(to: CGPoint(x: zeroPoint.x, y: self.bounds.maxY - 10))
        path.addLine(to: CGPoint(x: zeroPoint.x, y: self.bounds.minY + 10))
        path.move(to: CGPoint(x: self.bounds.minX + 10, y: zeroPoint.y))
        path.addLine(to: CGPoint(x: self.bounds.maxX - 10, y: zeroPoint.y))
        
        for i in -6...6 {
            path.move(to: CGPoint(x: zeroPoint.x + CGFloat(i) * scaleFactor, y: zeroPoint.y - 2))
            path.addLine(to: CGPoint(x: zeroPoint.x + CGFloat(i) * scaleFactor, y: zeroPoint.y + 2))
        }
        
        let e = Darwin.M_E
        if yExp {
            for i in 0...6 {
                path.move(to: CGPoint(x: zeroPoint.x - 2, y: zeroPoint.y - CGFloat(pow(e, Double(i))) * scaleFactor))
                path.addLine(to: CGPoint(x: zeroPoint.x + 2, y: zeroPoint.y - CGFloat(pow(e, Double(i))) * scaleFactor))
                
                path.move(to: CGPoint(x: zeroPoint.x - 2, y: zeroPoint.y + CGFloat(pow(e, Double(i))) * scaleFactor))
                path.addLine(to: CGPoint(x: zeroPoint.x + 2, y: zeroPoint.y + CGFloat(pow(e, Double(i))) * scaleFactor))
            }
        } else {
            for i in -6...6 {
                path.move(to: CGPoint(x: zeroPoint.x - 2, y: zeroPoint.y + CGFloat(i) * scaleFactor ))
                path.addLine(to: CGPoint(x: zeroPoint.x + 2, y: zeroPoint.y + CGFloat(i) * scaleFactor))
            }
        }
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "CustomDrawinglayer"
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = .none
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
    override func draw(_ rect: CGRect) {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == "CustomDrawinglayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        if !drapDiagram {
            
            drawCoordinateSystem()
            //design the path
            
            let path = UIBezierPath()
            
            
            let e = Darwin.M_E
            var startingPoint = CGPoint(x: -6, y: pow(e, -6))
            
            
            var point = CGPoint(x: zeroPoint.x + startingPoint.x * scaleFactor, y: zeroPoint.y + startingPoint.y * scaleFactor)
            startingPoint = point
            path.move(to: point)
            
            for x in stride(from: -6, through: 6, by: 0.1) {
                let dx = CGFloat(x) * scaleFactor
                let dy = CGFloat(pow(e, Double(x))) * scaleFactor
                point.x = (zeroPoint.x + dx )
                point.y = (startingPoint.y - dy )
                if self.frame.contains(point) {
                    path.addLine(to: point)
                }
            }
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.name = "CustomDrawinglayer"
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.fillColor = .none
            shapeLayer.lineWidth = 1.0
            
            self.layer.addSublayer(shapeLayer)
        } else {
           
            
            

            let colorPercent: [(UIColor, CGFloat)] = [(.red, 25/100), (.green, 35/100), (.yellow, 40/100)]
            var startAngle: CGFloat = -CGFloat.pi / 2
            
            for (color, percent) in colorPercent {
                let path = UIBezierPath()
                let endAngle = startAngle + 2 * CGFloat.pi * percent
                path.addArc(withCenter: zeroPoint, radius: 50, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                startAngle = endAngle
                let shapeLayer = CAShapeLayer()
                shapeLayer.name = "CustomDrawinglayer"
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = color.cgColor
                shapeLayer.fillColor = .none
                shapeLayer.lineWidth = 20

                self.layer.addSublayer(shapeLayer)
            }

        }
    }
    
    
}
