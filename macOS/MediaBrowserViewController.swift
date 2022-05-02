//
//  MediaBrowserViewController.swift
//  BXMediaBrowserDemo
//
//  Created by Peter Baumgartner on 06.02.22.
//

import AppKit
import BXMediaBrowser


class MediaBrowserViewController:NSViewController
{

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let browserView = BrowserView()
		
			.environmentObject(ImageLibrary.shared)
			.environmentObject(VideoLibrary.shared)
			.environmentObject(AudioLibrary.shared)
			.environmentObject(StatisticsController.shared)
			.environmentObject(AudioPreviewController.shared)
			.environment(\.viewFactory, CustomViewFactory())

		self.embedSwiftUI(browserView, in:self.view)
	}

}

