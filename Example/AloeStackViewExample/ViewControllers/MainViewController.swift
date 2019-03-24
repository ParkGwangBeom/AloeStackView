// Created by Marli Oshlack on 10/12/18.
// Copyright 2018 Airbnb, Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import AloeStackView
import UIKit

public class MainViewController: AloeStackViewController {

  // MARK: Public

  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpSelf()
    setUpStackView()
    setUpRows()
  }

  // MARK: Private

  private func setUpSelf() {
    title = "AloeStackView Example"
  }

  private func setUpStackView() {
    stackView.automaticallyHidesLastSeparator = true
  }

  private func setUpRows() {
    setUpDescriptionRow()
    setUpSwitchRow()
    setUpHiddenRows()
    setUpCustomAnimatingDescriptionRow()
    setUpCustomAnimatingRow()
    setUpSticyRow()
    setUpExpandingRowView()
    setUpPhotoRow()
  }

  private func setUpDescriptionRow() {
    let descriptionRow = TitleCaptionRowView(titleText: "This simple app shows some ways you can use AloeStackView to lay out a screen in your app.")
    stackView.addRow(descriptionRow)
  }

  private func setUpSwitchRow() {
    let switchRow = SwitchRowView()
    switchRow.text = "Show and hide rows with animation"
    switchRow.switchDidChange = { [weak self] isOn in
      guard let self = self else { return }
      self.stackView.setRowsHidden(self.hiddenRows, isHidden: !isOn, animated: true)
    }
    stackView.addRow(switchRow)
  }

  private let hiddenRows = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]

  private func setUpHiddenRows() {
    for (index, row) in hiddenRows.enumerated() {
      row.font = UIFont.preferredFont(forTextStyle: .caption2)
      row.text = "Hidden row " + String(index + 1)
    }

    stackView.addRows(hiddenRows)
    stackView.hideRows(hiddenRows)

    let rowInset = UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left * 2,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right)

    let separatorInset = UIEdgeInsets(
      top: 0,
      left: stackView.separatorInset.left * 2,
      bottom: 0,
      right: 0)

    stackView.setInset(forRows: hiddenRows, inset: rowInset)
    stackView.setSeparatorInset(forRows: Array(hiddenRows.dropLast()), inset: separatorInset)
  }

  private func setUpCustomAnimatingDescriptionRow() {
    let animatableRow = TitleCaptionRowView(titleText: "Customizing Row Animation", captionText: "(Try tapping on the Row!)")
    stackView.addRow(animatableRow)
    stackView.setTapHandler(forRow: animatableRow) { [weak self] _ in
      guard let `self` = self else { return }
      let isHidden = self.stackView.isRowHidden(self.customAnimatingLabel)
      self.stackView.setRowHidden(self.customAnimatingLabel, isHidden: !isHidden, animated: true)
    }
  }

  private let customAnimatingLabel = CustomAnimatingLabel()

  private func setUpCustomAnimatingRow() {
    customAnimatingLabel.text = "Customizing Row Animation"

    stackView.addRow(customAnimatingLabel)
    stackView.hideRow(customAnimatingLabel)

    let rowInset = UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left * 2,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right)

    stackView.setInset(forRow: customAnimatingLabel, inset: rowInset)
  }
    
  private func setUpSticyRow() {
    let stickyRow = StickyRowView()
    stickyRow.text = "Sticky Header"
    stickyRow.translatesAutoresizingMaskIntoConstraints = false
    stickyRow.backgroundColor = UIColor.groupTableViewBackground
    stackView.addRow(stickyRow)

    stickyRow.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }

  private func setUpExpandingRowView() {
    let expandingRow = ExpandingRowView()
    stackView.addRow(expandingRow)
  }

  private func setUpPhotoRow() {
    let row = TitleCaptionRowView(titleText: "Handle user interaction", captionText: "(Try tapping on the photo!)")
    stackView.addRow(row)
    stackView.hideSeparator(forRow: row)

    guard let image = UIImage(named: "lobster-dog") else { return }
    let aspectRatio = image.size.height / image.size.width

    let imageView = TempImageView(image: image)
    imageView.isUserInteractionEnabled = true
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

    stackView.addRow(imageView)
    stackView.setTapHandler(forRow: imageView) { [weak self] _ in
      guard let self = self else { return }
      let vc = PhotoViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

}

class TempImageView: UIImageView {
    
}
