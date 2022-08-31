//
//  DynamicTableView.swift
//  InternalApp
//
//  Created by Ping Identity on 14/11/2021.
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit

class DynamicTableView: UITableView {

    let cellHeight: CGFloat = 175.0
    let footer: CGFloat = 10.0
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        let numberOfCells = CGFloat(self.numberOfRows(inSection: 0))
        return CGSize(width: UIView.noIntrinsicMetric, height: CGFloat(numberOfCells * cellHeight) + footer)
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
