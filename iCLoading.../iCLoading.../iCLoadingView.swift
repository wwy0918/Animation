//
//  iCLoadingView.swift
//  iCLoading...
//
//  Created by wwyun on 16/9/9.
//  Copyright © 2016年 wwyun. All rights reserved.
//

enum AnimationStatus {
    case normal
    case animating
    case pause
}


import UIKit

class iCLoadingView: UIView {
    
    // 线宽
    var lineW:CGFloat = 0
    // 线长
    var lineL:CGFloat = 0
    // 边距
    var margin:CGFloat = 0
    // 线颜色
    var lineColors = [UIColor.init(rgba: "#9DD4E9") ,
                      UIColor.init(rgba: "#F5BD58"),
                      UIColor.init(rgba: "#FF317E") ,
                      UIColor.init(rgba: "#6FC9B5")]
    // 四条线
    var lines:[CAShapeLayer] = []
    // 动画时间
    var duration:Double = 1.5
    //动画的间隔时间
    var interval:Double = 1
    // 动画状态
    var status:AnimationStatus = .normal
    
   
    // MARK: initial Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    func config() {
        lineL = max(frame.width, frame.height)
        lineW = lineL/6.0
        margin = lineL/4.5 + lineW/2.0
        // 调整角度
        transform = CGAffineTransform.identity.rotated(by: angle(-30))
        drawLine()
    }
    
    // MARK: 画四条线
    func drawLine() {
        // 开始点
        let startPoints = [CGPoint(x: lineW/2, y: margin),
                          CGPoint(x: lineL - margin , y: lineW/2),
                          CGPoint(x: lineL - lineW/2,  y: lineL - margin),
                          CGPoint(x: margin, y: lineL - lineW/2)]
        // 结束点
        let endPoints   = [CGPoint(x: lineL - lineW/2, y: margin) ,
                           CGPoint(x: lineL - margin, y: lineL - lineW/2) ,
                           CGPoint(x: lineW/2, y: lineL - margin) ,
                           CGPoint(x: margin, y: lineW/2)]
        
        for i in 0...3 {
            let line = CAShapeLayer()
            line.lineWidth = lineW
            line.lineCap = kCALineCapRound
            line.opacity = 0.8
            line.strokeColor = lineColors[i].cgColor
            // 贝塞尔曲线
            let path = UIBezierPath()
            path.move(to: startPoints[i])
            path.addLine(to: endPoints[i])
            line.path = path.cgPath
            
            layer.addSublayer(line)
            lines.append(line)
        }
    }
    
    // MARK: 动画解析
    // step1:  旋转
    func rotationAnimation() {
        let rotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotation.fromValue = angle(-30)
        rotation.toValue = angle(690)
        rotation.fillMode = kCAFillModeForwards
        rotation.isRemovedOnCompletion = false
        rotation.duration = duration
        rotation.delegate = self
        layer.add(rotation, forKey: "rotation")
    }
    
    // step2:  线长变短
    func lineAnimationOne() {
        let lineAniOne = CABasicAnimation.init(keyPath: "strokeEnd")
        lineAniOne.duration = duration/2;
        lineAniOne.fillMode = kCAFillModeForwards
        lineAniOne.isRemovedOnCompletion = false
        lineAniOne.toValue = 0
        for lineLayer in lines {
            lineLayer.add(lineAniOne, forKey: "lineAniOne")
        }
    }
    
    // step3:  线条位移
    func lineAniTwo() {
        for i in 0...3 {
            var keyPath = "transform.translation.x"
            if i%2 == 1 {
                keyPath = "transform.translation.y"
            }
            let lineAniTwo = CABasicAnimation.init(keyPath: keyPath)
            lineAniTwo.beginTime = CACurrentMediaTime() + duration/2
            lineAniTwo.duration = duration/4
            lineAniTwo.fillMode = kCAFillModeForwards
            lineAniTwo.isRemovedOnCompletion = false
            lineAniTwo.autoreverses = true
            lineAniTwo.fromValue = 0
            if i < 2 {
                lineAniTwo.toValue = lineL/4
            }else {
                lineAniTwo.toValue = -lineL/4
            }
            let lineLayer = lines[i]
            lineLayer.add(lineAniTwo, forKey: "lineAnimationTwo")
        }
        
        //三角形两边的比例
        let scale = (lineL - 2*margin)/(lineL - lineW)
        for i in 0...3 {
            var keypath = "transform.translation.y"
            if i%2 == 1 {
                keypath = "transform.translation.x"
            }
            let lineAnimationTwo = CABasicAnimation.init(keyPath: keypath)
            lineAnimationTwo.beginTime = CACurrentMediaTime() + duration/2
            lineAnimationTwo.duration = duration/4
            lineAnimationTwo.fillMode = kCAFillModeForwards
            lineAnimationTwo.isRemovedOnCompletion = false
            lineAnimationTwo.autoreverses = true
            lineAnimationTwo.fromValue = 0
            if i == 0 || i == 3 {
                lineAnimationTwo.toValue = lineL/4 * scale
            }else {
                lineAnimationTwo.toValue = -lineL/4 * scale
            }
            let lineLayer = lines[i]
            lineLayer.add(lineAnimationTwo, forKey: "lineAnimationThree")
        }
    }
    
    // step4:  恢复线条长度
    func lineAnimationThree() {
        let lineAniThree = CABasicAnimation.init(keyPath: "strokeEnd")
        lineAniThree.beginTime = CACurrentMediaTime() + duration
        lineAniThree.duration = duration/4;
        lineAniThree.fillMode = kCAFillModeForwards
        lineAniThree.isRemovedOnCompletion = false
        lineAniThree.toValue = 1
        
        for i in 0...3 {
            if i == 3 {
                lineAniThree.delegate = self
            }
            lines[i].add(lineAniThree, forKey: "lineAniThree")
        }
        
    }
    
    
    // MRAK: 开始动画
    func startAnimation() {

        rotationAnimation()
        lineAnimationOne()
        lineAniTwo()
        lineAnimationThree()
    }
    
    /**
     暂停动画
     */
    func pauseAnimation() {
        layer.pauseAnimation()
        for lineLayer in lines {
            lineLayer.pauseAnimation()
        }
        status = .pause
    }
    
    /**
     继续动画
     */
    func resumeAnimation() {
        layer.resumeAnimation()
        for lineLayer in lines {
            lineLayer.resumeAnimation()
        }
        status = .animating
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch status {
        case .animating:
            pauseAnimation()
        case .pause:
            resumeAnimation()
        case .normal:
            startAnimation()
        }
    }
    
    //MARK: Animation Delegate
     func animationDidStart(_ anim: CAAnimation) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath == "transform.rotation.z" {
                status = .animating
            }
        }
    }
    
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath == "strokeEnd" {
                if flag {
                    status = .normal
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(interval) * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                        if self.status != .animating {
                            self.startAnimation()
                        }
                    })
                }
            }
        }
    }
    
    
    func angle(_ angle:Double) -> CGFloat {
        return CGFloat(angle * (M_PI/180))
    }
}

extension CALayer {
    //暂停动画
    func pauseAnimation() {
        // 将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为localtime
        let pauseTime = convertTime(CACurrentMediaTime(), from: nil)
        // 设置layer的timeOffset, 在继续操作也会使用到
        timeOffset    = pauseTime
        // localtime与parenttime的比例为0, 意味着localtime暂停了
        speed         = 0;
    }
    
    //继续动画
    func resumeAnimation() {
        let pausedTime = timeOffset
        speed          = 1
        timeOffset     = 0;
        beginTime      = 0
        // 计算暂停时间
        let sincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        // local time相对于parent time时间的beginTime
        beginTime      = sincePause
    }
}

