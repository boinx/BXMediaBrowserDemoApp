//----------------------------------------------------------------------------------------------------------------------
//
//  Copyright ©2022 Peter Baumgartner. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//----------------------------------------------------------------------------------------------------------------------


import SwiftUI
import BXMediaBrowser


//----------------------------------------------------------------------------------------------------------------------


@main struct MediaBrowserTestApp : App
{
	// Setup
	
	init()
	{
		ProcessInfo.processInfo.disableSuddenTermination()
	}
	
    var body: some Scene
    {
		// Window & View hierarchy
		
        WindowGroup
        {
			BrowserView()
				.environmentObject(ImageLibrary.shared)
				.environmentObject(VideoLibrary.shared)
				.environmentObject(AudioLibrary.shared)
				.environment(\.viewFactory, CustomViewFactory())
        }
       
        // Menu items
        
        .commands
        {
			
			CommandGroup(after:.newItem)
			{
				Button("Add Image Folder…")
				{
					let library = ImageLibrary.shared
					let source = library.folderSource
					library.addFolder(to:source)
				}

				Button("Add Video Folder…")
				{
					let library = VideoLibrary.shared
					let source = library.folderSource
					library.addFolder(to:source)
				}

				Button("Add Audio Folder…")
				{
					let library = AudioLibrary.shared
					let source = library.folderSource
					library.addFolder(to:source)
				}
			}
		}
    }
}


//----------------------------------------------------------------------------------------------------------------------
