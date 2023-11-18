//
//  Factories.swift
//  Bankey
//
//  Created by admin on 18/11/2023.
//

import UIKit

public func makeTextField(withPlaceholder placeholder: String = "") -> UITextField  {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
}

public func makeStackView(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    return stackView
}

public func makeButton(withTitle title: String = "Button") -> UIButton{
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.configuration = .filled()
    button.configuration?.imagePadding = 8
    button.setTitle(title, for: [])
    return button
}

public func makeLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    return label
}
