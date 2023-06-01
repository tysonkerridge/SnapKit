//
//  UIView+Extensions.swift
//  SnapKit
//
//  Created by Tyson Kerridge on 1/6/2023.
//  Copyright © 2023 SnapKit Team. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UIView {
    
    /// Adds the passed `view` as a subview of the receiver and adds the passed `constraints` to the `view`.
    ///
    /// Handy helper to reduce a line of code when adding subviews with constraints via SnapKit.
    func addSubview(_ view: UIView, withConstraints constraints: (ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints(constraints)
    }
    
    func addSubview(_ view: UIView, withConstraints constraints: (ConstraintMaker, _ superview: UIView) -> Void) {
        addSubview(view) { constraints($0, self) }
    }
    
    func makeConstraints(_ constraints: (ConstraintMaker, _ superview: UIView) -> Void) {
        snp.makeConstraints { constraints($0, self.superview!) }
    }
    
    func addSubviewWithEdgeConstraints(_ view: UIView) {
        self.addSubview(view) { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func addSubview(_ view: UIView, withEdgeConstraintsTo other: ConstraintRelatableTarget) {
        self.addSubview(view) { (make) in
            make.edges.equalTo(other)
        }
    }
    
    func addLayoutGuide(_ layoutGuide: UILayoutGuide, withConstraints constraints: (ConstraintMaker) -> Void) {
        self.addLayoutGuide(layoutGuide)
        layoutGuide.snp.makeConstraints(constraints)
    }
    
    func addLayoutGuide(_ layoutGuide: UILayoutGuide, withConstraints constraints: (ConstraintMaker, _ superview: UIView) -> Void) {
        self.addLayoutGuide(layoutGuide) { constraints($0, self) }
    }
    
}

#endif

public extension Constraint {
    func setActive(_ active: Bool) {
        if active {
            activate()
        } else {
            deactivate()
        }
    }
}

public extension Array where Element == Constraint {
    func activate() {
        forEach { $0.activate() }
    }
    func deactivate() {
        forEach { $0.deactivate() }
    }
}
