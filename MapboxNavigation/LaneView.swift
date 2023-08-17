import UIKit
import MapboxDirections

/// :nodoc:
open class LaneView: UIView {
    @IBInspectable
    var scale: CGFloat = 1
    let invalidAlpha: CGFloat = 0.4
    
    var lane: LaneIndication?
    var maneuverDirection: ManeuverDirection?
    var isValid: Bool = false
    
    override open var intrinsicContentSize: CGSize {
        return bounds.size
    }
    
    @objc public dynamic var primaryColor: UIColor = .defaultLaneArrowPrimary {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @objc public dynamic var secondaryColor: UIColor = .defaultLaneArrowSecondary {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var appropriatePrimaryColor: UIColor {
        return isValid ? primaryColor : secondaryColor
    }
    
    static let defaultFrame: CGRect = CGRect(origin: .zero, size: 30.0)
    
    convenience init(component: LaneIndication, isUsable: Bool, maneuverDirection: ManeuverDirection) {
        self.init(frame: LaneView.defaultFrame)
        backgroundColor = .clear
        lane = component
        self.maneuverDirection = maneuverDirection
        isValid = isUsable
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        if let lane = lane {
            var flipLane: Bool
            if lane.isSuperset(of: [.straightAhead, .sharpRight]) || lane.isSuperset(of: [.straightAhead, .right]) || lane.isSuperset(of: [.straightAhead, .slightRight]) {
                flipLane = false
                if !isValid {
                    if lane == .slightRight {
                        LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    } else {
                        LanesStyleKit.drawLane_straight_right(primaryColor: appropriatePrimaryColor)
                    }
                    alpha = invalidAlpha
                } else if maneuverDirection == .straightAhead {
                    LanesStyleKit.drawLane_straight_only(primaryColor: appropriatePrimaryColor, secondaryColor: secondaryColor)
                } else if maneuverDirection == .sharpLeft || maneuverDirection == .left || maneuverDirection == .slightLeft {
                    if lane == .slightLeft {
                        LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    } else {
                        LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    }
                    flipLane = true
                } else {
                    LanesStyleKit.drawLane_right_only(primaryColor: appropriatePrimaryColor, secondaryColor: secondaryColor)
                }
            } else if lane.isSuperset(of: [.straightAhead, .sharpLeft]) || lane.isSuperset(of: [.straightAhead, .left]) || lane.isSuperset(of: [.straightAhead, .slightLeft]) {
                flipLane = true
                if !isValid {
                    if lane == .slightLeft {
                        LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    } else {
                        LanesStyleKit.drawLane_straight_right(primaryColor: appropriatePrimaryColor)
                    }
                    
                    alpha = invalidAlpha
                } else if maneuverDirection == .straightAhead {
                    LanesStyleKit.drawLane_straight_only(primaryColor: appropriatePrimaryColor, secondaryColor: secondaryColor)
                } else if maneuverDirection == .sharpRight || maneuverDirection == .right {
                    LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    flipLane = false
                } else if maneuverDirection == .slightRight {
                    LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    flipLane = false
                } else {
                    LanesStyleKit.drawLane_right_only(primaryColor: appropriatePrimaryColor, secondaryColor: secondaryColor)
                }
            } else if lane.description.components(separatedBy: ",").count >= 2 {
                // Hack:
                // Account for a configuation where there is no straight lane
                // but there are at least 2 indications.
                // In this situation, just draw a left/right arrow
                if maneuverDirection == .sharpRight || maneuverDirection == .right {
                    LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    flipLane = false
                } else if maneuverDirection == .slightRight {
                    LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    flipLane = false
                } else {
                    LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    flipLane = true
                }
                alpha = isValid ? 1 : invalidAlpha
            } else if lane.isSuperset(of: [.sharpRight]) || lane.isSuperset(of: [.right]) || lane.isSuperset(of: [.slightRight]) {
                if lane == .slightRight {
                    LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                } else {
                    LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                }
                flipLane = false
                alpha = isValid ? 1 : invalidAlpha
            } else if lane.isSuperset(of: [.sharpLeft]) || lane.isSuperset(of: [.left]) || lane.isSuperset(of: [.slightLeft]) {
                if lane == .slightLeft {
                    LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                } else {
                    LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                }
                flipLane = true
                alpha = isValid ? 1 : invalidAlpha
            } else if lane.isSuperset(of: [.straightAhead]) {
                LanesStyleKit.drawLane_straight(primaryColor: appropriatePrimaryColor)
                flipLane = false
                alpha = isValid ? 1 : invalidAlpha
            } else if lane.isSuperset(of: [.uTurn]) {
                LanesStyleKit.drawLane_uturn(primaryColor: appropriatePrimaryColor)
                flipLane = false
                alpha = isValid ? 1 : invalidAlpha
            } else if lane.isEmpty && isValid {
                // If the lane indication is `none` and the maneuver modifier has a turn in it,
                // show the turn in the lane image.
                if maneuverDirection == .sharpRight || maneuverDirection == .right || maneuverDirection == .slightRight {
                    if maneuverDirection == .slightRight {
                        LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    } else {
                        LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    }
                    flipLane = false
                } else if maneuverDirection == .sharpLeft || maneuverDirection == .left || maneuverDirection == .slightLeft {
                    if maneuverDirection == .slightLeft {
                        LanesStyleKit.drawLane_slight_right(primaryColor: appropriatePrimaryColor)
                    } else {
                        LanesStyleKit.drawLane_right_h(primaryColor: appropriatePrimaryColor)
                    }
                    flipLane = true
                } else {
                    LanesStyleKit.drawLane_straight(primaryColor: appropriatePrimaryColor)
                    flipLane = false
                }
            } else {
                LanesStyleKit.drawLane_straight(primaryColor: appropriatePrimaryColor)
                flipLane = false
                alpha = isValid ? 1 : invalidAlpha
            }
            
            transform = CGAffineTransform(scaleX: flipLane ? -1 : 1, y: 1)
        }
        
        #if TARGET_INTERFACE_BUILDER
            isValid = true
            LanesStyleKit.drawLane_right_only(primaryColor: appropriatePrimaryColor, secondaryColor: secondaryColor)
        #endif
    }
}
