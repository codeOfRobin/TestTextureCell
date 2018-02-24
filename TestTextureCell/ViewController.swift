//
//  ViewController.swift
//  TestTextureCell
//
//  Created by Robin Malhotra on 23/02/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController, ASTableDataSource {

	let tableNode = ASTableNode(style: .plain)

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubnode(tableNode)
		tableNode.dataSource = self
		// Do any additional setup after loading the view, typically from a nib.
	}

	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}

	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return 2
	}

	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		return MultipleStateCell()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableNode.frame = view.frame
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

