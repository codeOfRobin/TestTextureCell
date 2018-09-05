//
//  MultipleStateCell.swift
//  TestTextureCell
//
//  Created by Robin Malhotra on 24/02/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

class MultipleStateCell: ASCellNode {

	enum State {
		case one
		case two

		func toggle() -> State {
			switch self {
			case .one:
				return .two
			case .two:
				return .one
			}
		}
	}

	var state: State = .one

	let smallRedNode = ASDisplayNode()
	let bigBlueNode = ASDisplayNode()

	let toggle: ASDisplayNode

	var switchView: UISwitch? {
		guard let toggle = (self.toggle.view as? UISwitch) else {
			return nil
		}
		return toggle
	}

	override init() {
		self.toggle = ASDisplayNode(viewBlock: { () -> UIView in
			return UISwitch()
		})

		super.init()

		smallRedNode.style.width = ASDimensionMake(100)
		smallRedNode.style.height = ASDimensionMake(100)
		smallRedNode.backgroundColor = .red

		bigBlueNode.style.width = ASDimensionMake(200)
		bigBlueNode.style.height = ASDimensionMake(200)
		bigBlueNode.backgroundColor = .blue

		toggle.style.height = ASDimensionMake(31)
		toggle.style.width = ASDimensionMake(51)
		toggle.backgroundColor = .white

		switchView?.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        self.addSubnode(smallRedNode)
        self.addSubnode(toggle)
	}

	@objc func stateChanged() {
		self.state = self.state.toggle()
		self.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
        switch state {
        case .one:
            self.addSubnode(smallRedNode)
            bigBlueNode.removeFromSupernode()
        case .two:
            self.addSubnode(bigBlueNode)
            smallRedNode.removeFromSupernode()
        }
		self.setNeedsLayout()
	}


	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let bottomHalfNode: ASDisplayNode = {
			switch state {
			case .one:
				return smallRedNode
			case .two:
				return bigBlueNode
			}
		}()

		return ASStackLayoutSpec.init(direction: .vertical, spacing: 4.0, justifyContent: .center, alignItems: .center, children: [toggle, bottomHalfNode])
	}

}
