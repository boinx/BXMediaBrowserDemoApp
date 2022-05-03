//
//  com_boinx_BXMediaBrowser_demo_iOSApp.swift
//  com.boinx.BXMediaBrowser.demo.iOS
//
//  Created by Peter Baumgartner on 02.05.22.
//

import SwiftUI
import BXMediaBrowser


@main struct MediaBrowserApp : App
{
    var body: some Scene
    {
        WindowGroup
        {
            BrowserView()
            
				.environmentObject(ImageLibrary.shared)
				.environmentObject(VideoLibrary.shared)
				.environmentObject(AudioLibrary.shared)
				.environmentObject(StatisticsController.shared)
				.environmentObject(AudioPreviewController.shared)
				
				.environment(\.viewFactory, CustomViewFactory())
        }
    }
}
