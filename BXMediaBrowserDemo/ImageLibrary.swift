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
import BXSwiftUtils


//----------------------------------------------------------------------------------------------------------------------


class ImageLibrary : GenericLibrary
{
	/// Shared singleton instance
	
	static let shared = ImageLibrary(identifier:"ImageLibrary")
	
	
	/// Creates the basic structure of the ImageLibrary
	
	override init(identifier:String)
	{
		super.init(identifier:identifier)

		let photosSource = PhotosSource()
		librariesSection?.addSource(photosSource)
		
		if let data = BXKeychain.data(forKey:"api_unsplash_com_accessKey")
		{
			let key = String(decoding:data, as:UTF8.self)
			UnsplashConfig.shared.accessKey = key
			let unsplashSource = UnsplashSource()
			internetSection?.addSource(unsplashSource)
		}
 
 		let folderSource = ImageFolderSource()
		self.folderSource = folderSource
		foldersSection?.addSource(folderSource)
		
		self.load(with:self.state)
	}
	

 	/// Creates a ImageFolderContainer for the specified folder URL
	
   override func createContainer(for url:URL) -> FolderContainer
    {
		ImageFolderContainer(url:url)
		{
			[weak self] in self?.folderSource?.removeContainer($0)
		}
    }

}


//----------------------------------------------------------------------------------------------------------------------
