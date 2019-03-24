//
//  StickyLayoutController.swift
//  AloeStackView
//
//  Created by NAVER on 17/03/2019.
//  Copyright © 2019 Airbnb, Inc. All rights reserved.
//

import UIKit

internal enum StickyPosition {

  case top
    
  case bottom

}

internal class StickyController: NSObject {
    
  private weak var stackView: AloeStackView?
  private var stickyRows: [StackViewCell] = []
  private var topY: [CGFloat] = [84.5, 437.75 - 84.5, 942.25 - 84.5]
    
  private var observer: NSKeyValueObservation?
    
  required init(stackView: AloeStackView) {
    super.init()
    self.stackView = stackView
    observer = stackView.observe(\.contentOffset, options: [.new]) { [weak self] stackView, change in
      guard let `self` = self else { return }
      let contentOffset = change.newValue ?? .zero
      self.stickyRows.enumerated().forEach { index, cell in
//        let top = self.topY[index] // 위쪽 셀들의 높이 합
        let limit = cell.convert(cell.bounds, to: self.stackView).origin.y
        print(limit)
        print(contentOffset.y)
        print(max(0, contentOffset.y - 84.5))
//        print("\(min(limit, max(0, contentOffset.y - 84.5)))")
//              cell.backgroundColor = .white
        cell.transform = CGAffineTransform(translationX: 0, y: min(limit, max(0, contentOffset.y - 84.5)))
        }
      }
    }
    
  deinit {
    observer = nil
  }

  internal func updateStickyRows() {
    stickyRows = stackView?.getAllRows()
      .filter { $0 is Stickyable }
      .compactMap { $0.superview as? StackViewCell } ?? []
        
        // update z position
    stickyRows.forEach { $0.layer.zPosition = 1 }
  }
}
