//
//  MediaBrowserTestApp.swift
//  MediaBrowserTest
//
//  Created by Peter Baumgartner on 04.12.21.
//

import SwiftUI
import BXMediaBrowser


//----------------------------------------------------------------------------------------------------------------------


@main struct MediaBrowserTestApp : App
{
//	let willTerminate:Any
	
	
	init()
	{
		SampleLibrary.shared.load()
		
//		willTerminate = NotificationCenter.default.publisher(for:NSApplication.willTerminateNotification, object:nil).sink
//		{
//			_ in SampleLibrary.shared.saveState()
//		}
	}
	
	
    var body: some Scene
    {
		// Window & View hierarchy
		
        WindowGroup
        {
			BrowserView(with:SampleLibrary.shared)
        }
       
        // Menu items
        
        .commands
        {
			CommandGroup(after:.newItem)
			{
				Button("Add Container…")
				{
					SampleLibrary.shared.addFolder()
				}
				.keyboardShortcut("O")
			}
		}
		
    }
}


//----------------------------------------------------------------------------------------------------------------------


