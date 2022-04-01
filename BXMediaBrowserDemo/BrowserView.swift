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
	// Environment
	
	@EnvironmentObject var imageLibrary:ImageLibrary
	@EnvironmentObject var videoLibrary:VideoLibrary
	@EnvironmentObject var audioLibrary:AudioLibrary
	
	@Environment(\.viewFactory) private var viewFactory
	
	// Switch between different libraries
	
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
	
	private var selectedUIState:UIState
	{
		switch mediaType
		{
			case 1 : return videoUIState
			case 2 : return audioUIState
			default: return imageUIState
		}
	}

	let imageUIState = UIState()
	let videoUIState = UIState()
	let audioUIState = UIState()
	
	// Build View
	
    var body: some View
    {
		HSplitView
		{
			self.sidebar
			self.objectBrowser.layoutPriority(1)
		}
    }
    
    // Sidebar View
    
    var sidebar: some View
    {
		VStack
		{
			Picker("", selection:$mediaType)
			{
				Text(Library.localizedNameImages).tag(0)
				Text(Library.localizedNameVideos).tag(1)
				Text(Library.localizedNameAudio).tag(2)
			}
			.pickerStyle(.segmented)
			.padding(10)
			
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
		.frame(minWidth:240)
    }
    
    // Object Browser
    
	var objectBrowser: some View
    {
		let library = self.selectedLibrary
		let uiState = self.selectedUIState
		let container = library.selectedContainer
		let cellType = viewFactory.objectViewControllerType(for:container, uiState:uiState)

		return VStack(spacing:0)
		{
			viewFactory.objectsHeaderView(for:container, uiState:uiState)
			
			Color.primary.opacity(0.15).frame(height:1) // Divider line
			
			ObjectCollectionView(container:container, cellType:cellType, uiState:uiState)
			
			Color.primary.opacity(0.15).frame(height:1) // Divider line

			viewFactory.objectsFooterView(for:container, uiState:uiState)
		}
		.frame(minWidth:240, maxWidth:.infinity)
    }

}


//----------------------------------------------------------------------------------------------------------------------


