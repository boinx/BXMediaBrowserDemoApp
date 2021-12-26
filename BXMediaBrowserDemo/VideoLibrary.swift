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


import AppKit
import BXMediaBrowser


//----------------------------------------------------------------------------------------------------------------------


class VideoLibrary : GenericLibrary
{
	/// Shared singleton instance
	
	static let shared = VideoLibrary(identifier:"Videos")
	
	
	/// Creates the basic structure of the SampleLibrary
	
	override init(identifier:String)
	{
		super.init(identifier:identifier)
		
		let photosSource = PhotosSource()
		librariesSection?.addSource(photosSource)
		
		let folderSource = VideoFolderSource()
		self.folderSource = folderSource
		foldersSection?.addSource(folderSource)

		self.load()
	}
	
	
	/// Creates a VideoFolderContainer for the specified folder URL
	
    override func createContainer(for url:URL) -> FolderContainer
    {
		VideoFolderContainer(url:url)
    }
}


//----------------------------------------------------------------------------------------------------------------------