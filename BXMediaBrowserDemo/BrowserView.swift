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


struct BrowserView : View
{
	@EnvironmentObject var imageLibrary:ImageLibrary
	@EnvironmentObject var videoLibrary:VideoLibrary
	@EnvironmentObject var audioLibrary:AudioLibrary
	
	@State private var mediaType = 0
	
	private var selectedLibrary:Library
	{
		switch mediaType
		{
			case 1 : return videoLibrary
			case 2 : return audioLibrary
			default: return imageLibrary
		}
	}
	
    var body: some View
    {
		let container = self.selectedLibrary.selectedContainer

		return HSplitView
		{
			// Sidebar
			
			VStack
			{
				// MediaType
				
				Picker("", selection:$mediaType)
				{
					Text("Images").tag(0)
					Text("Videos").tag(1)
					Text("Audio").tag(2)
				}
				.pickerStyle(.segmented)
				.padding(10)
				
				// Library
				
				ScrollView
				{
					if mediaType == 0
					{
						LibraryView(with:imageLibrary)
					}
					else if mediaType == 1
					{
						LibraryView(with:videoLibrary)
					}
					else if mediaType == 2
					{
						LibraryView(with:audioLibrary)
					}
				}
			}
			.background(.thinMaterial)
			.frame(minWidth:240)
			
			VStack
			{
				if let container = container
				{
					SearchBar(with:selectedLibrary)
						.environmentObject(container)
				}

				// Selected Container with Objects
			
//				if let container = container
//				{
///					ObjectsView(with:container)
//				}
//				else
//				{
//					EmptyObjectsView()
//				}

				CollectionView(container:container, cellType:ImageThumbnailCell.self)
			}
			.environmentObject(self.selectedLibrary)
			.frame(minWidth:240, maxWidth:.infinity)
			.layoutPriority(1)
		}
    }
}


//----------------------------------------------------------------------------------------------------------------------


