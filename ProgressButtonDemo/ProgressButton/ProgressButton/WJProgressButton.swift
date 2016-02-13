//
//  WJProgressButton.swift
//  ProgressButton
//
//  Created by WJ on 16/2/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

import UIKit

@IBDesignable
class WJProgressButton: UIButton {
    @IBInspectable
    var progress:CGFloat = 0 {
        didSet{
            if progress > 1{
                progress = 1
            }else if progress < 0{
                progress = 0
            }
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var progressFontColor:UIColor?
    @IBInspectable
    var progressBackgroundColor:UIColor?
    
    private func getProgressFontColor()->UIColor{
        guard progressFontColor == nil else {return progressFontColor!}
        
        guard layer.backgroundColor == nil else {return UIColor(CGColor: layer.backgroundColor!)}
        
        return UIColor.whiteColor()
    }
    
    private func getProgressBackgroundColor()->UIColor{
        guard progressBackgroundColor == nil else {return progressBackgroundColor!}
        
        if let cl = titleColorForState(.Normal) {return cl }
        
        return UIColor.redColor()
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if progress > 0 && currentTitle != nil{
            var alpha = titleLabel!.alpha == 0 ? 1 : titleLabel!.alpha

            

            let ctx = UIGraphicsGetCurrentContext()
            
            //draw right text
            CGContextSaveGState(ctx)
            CGContextSetAlpha(ctx, alpha)
            titleLabel?.drawTextInRect(titleLabel!.frame)
            CGContextRestoreGState(ctx)
            
            //draw left background color
            CGContextSaveGState(ctx)
            let leftRect = CGRectMake(CGRectGetMinX(rect),
                                      CGRectGetMinY(rect),
                                      CGRectGetWidth(rect) * progress,
                                      CGRectGetHeight(rect))
            let path = UIBezierPath(rect: leftRect)
             path.addClip()
            getProgressBackgroundColor().setFill()
            path.fill()
            
            //draw left text
            if !enabled{
                alpha = 0.2
            }
            CGContextSetAlpha(ctx, alpha)
            let label = deepCopyLabel(titleLabel!)
            label.textColor = getProgressFontColor()
            label.drawTextInRect(label.frame)
            
            CGContextRestoreGState(ctx)
        }
        titleLabel?.alpha = (progress > 0) ? 0 : 1
    }
    
    func deepCopyLabel(label:UILabel)->UILabel{
        let archivedData = NSKeyedArchiver.archivedDataWithRootObject(label)
        let deeplabel    = NSKeyedUnarchiver.unarchiveObjectWithData(archivedData)!
        return deeplabel as! UILabel
    }
    
//MARK: - ChangeState
    override var highlighted: Bool{
        didSet{
            setNeedsDisplay()
        }
    }
}


