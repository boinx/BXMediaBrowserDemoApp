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


import BXMediaBrowser
import BXSwiftUtils
import SwiftUI


//----------------------------------------------------------------------------------------------------------------------


@main struct MediaBrowserTestApp : App
{
	// Setup
	
	init()
	{
		ProcessInfo.processInfo.disableSuddenTermination()
		Self.openLogFile()
	}
	
    var body: some Scene
    {
		// Window & View hierarchy
		
        WindowGroup("Media Browser")
        {
			BrowserView()
				.environmentObject(ImageLibrary.shared)
				.environmentObject(VideoLibrary.shared)
				.environmentObject(AudioLibrary.shared)
				.environment(\.viewFactory, CustomViewFactory())
        }
    }
}


//----------------------------------------------------------------------------------------------------------------------


// MARK: - Logging
		
extension MediaBrowserTestApp
{

	/// Returns the URL of the local log file
	
	static private var logFileURL: URL?
	{
		if let appSupportURL = FileManager.default.urls(for:.applicationSupportDirectory, in:.userDomainMask).first
		{
			return appSupportURL.appendingPathComponent("BXMediaBrowserDemoLog.txt")
		}
			
		return nil
	}
	
	
	/// Opens a log file in the application support directory
	
	static public func openLogFile()
	{
		if let url = self.logFileURL
		{
			try? BXLogger.truncateLogFile(at:url, toMaxSize:1000000)
			try? BXLogger.openLogFile(at:url)
			BXSwiftUtils.log.addDestination(BXLogger.fileDestination)
		}
		
		BXMediaBrowser.log.maxLevel = .debug 					// Root logger can disable all logging!
		BXMediaBrowser.logDataModel.maxLevel = .warning
		BXMediaBrowser.FolderSource.log.maxLevel = .warning
		BXMediaBrowser.MusicSource.log.maxLevel = .warning
		BXMediaBrowser.PhotosSource.log.maxLevel = .warning
		BXMediaBrowser.UnsplashSource.log.maxLevel = .warning
	}
	
	
	/// Closes the log file
	
	static public func closeLogFile()
	{
		BXLogger.closeLogFile()
	}
}


//----------------------------------------------------------------------------------------------------------------------
