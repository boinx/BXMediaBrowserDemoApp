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
import Foundation


//----------------------------------------------------------------------------------------------------------------------


class VideoLibrary : GenericLibrary
{
	/// Shared singleton instance
	
	static let shared = VideoLibrary(identifier:"VideoLibrary")
	
	
	/// Creates the basic structure of the VideoLibrary
	
	override init(identifier:String)
	{
		super.init(identifier:identifier)
		
		let photosSource = PhotosSource(allowedMediaTypes:[.video])
		librariesSection?.addSource(photosSource)
		
 		if let data = BXKeychain.data(forKey:"api_pexels_com_accessKey")
		{
			let key = String(decoding:data, as:UTF8.self)
			Pexels.shared.accessKey = key
			let pexelsSource = BXMediaBrowser.PexelsVideoSource()
			internetSection?.addSource(pexelsSource)
		}
 
		let folderSource = VideoFolderSource()
		self.folderSource = folderSource
		foldersSection?.addSource(folderSource)

		self.load(with:self.state)
	}
	
	
	/// Creates a VideoFolderContainer for the specified folder URL
	
    override func createContainer(for url:URL) -> FolderContainer
    {
		let filter = self.folderSource?.filter as? FolderFilter ?? FolderFilter()
		
		return VideoFolderContainer(url:url, filter:filter)
		{
			[weak self] in self?.removeTopLevelFolder($0)
		}
    }
}


//----------------------------------------------------------------------------------------------------------------------
