//
//  MediaBrowserViewController.swift
//  BXMediaBrowserDemo
//
//  Created by Peter Baumgartner on 06.02.22.
//

import AppKit
import BXMediaBrowser


class DropTargetViewController:NSViewController
{
	@IBOutlet weak var textView:DropTargetView?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		if let dropView = self.textView
		{
			let url = URL(fileURLWithPath:"/Users/peter/Desktop")
			FolderDropDestination.registerDragTypes(for:dropView)
			dropView.fileDropDestination = FolderDropDestination(folderURL:url)
		}
	}

}


class DropTargetView :NSTextView
{
	public var fileDropDestination:FolderDropDestination? = nil

	override func awakeFromNib()
	{
		super.awakeFromNib()
	}
	
	// MARK: - NSDraggingDestination
	
	
	override open func draggingEntered(_ sender:NSDraggingInfo) -> NSDragOperation
    {
 		return self.fileDropDestination?.draggingEntered(sender) ?? []
    }

    override open func draggingExited(_ sender:NSDraggingInfo?)
    {
 		self.fileDropDestination?.draggingExited(sender)
    }

	override open func concludeDragOperation(_ sender:NSDraggingInfo?)
    {
 		self.fileDropDestination?.concludeDragOperation(sender)
    }

	override open func performDragOperation(_ sender:NSDraggingInfo) -> Bool
	{
		return self.fileDropDestination?.performDragOperation(sender) ?? false
	}


}
