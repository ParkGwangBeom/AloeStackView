// Created by gwangbeom on 03/24/19.
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

import UIKit
import AloeStackView

public class StickyRowView: UIView, Stickyable {
    
    // MARK: Lifecycle
    
    public init() {
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    public var text: String? {
        get { return label.text }
        set { label.text = newValue}
    }

    // MARK: Private
    
    private let label = UILabel()
    
    private func setUpViews() {
        setUpLabel()
    }
    
    private func setUpLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        addSubview(label)
    }
 
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            ])
    }
    
}

