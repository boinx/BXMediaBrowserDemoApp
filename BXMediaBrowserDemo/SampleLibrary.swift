//
//  MediaBrowserTestApp.swift
//  MediaBrowserTest
//
//  Created by Peter Baumgartner on 04.12.21.
//

import AppKit
import BXMediaBrowser


//----------------------------------------------------------------------------------------------------------------------


class SampleLibrary : Library
{
	/// Shared singleton instance of the SampleLibrary
	
	static let shared = SampleLibrary(identifier:"Images")
	
	/// This reference to the FolderSource is needed by the addFolder() function
	
	var folderSource:FolderSource? = nil
	
	/// Creates the basic structure of the SampleLibrary
	
	override init(identifier:String)
	{
		super.init(identifier:identifier)
		
		let section1 = Section(identifier:"Libraries", name:"Libraries")
		self.addSection(section1)
		
		let section2 = Section(identifier:"Internet", name:"Internet")
		self.addSection(section2)
		
		let section3 = Section(identifier:"Folders", name:"Folders")
		section3.addSourceHandler = { [weak self] _ in self?.addFolder() }
		self.addSection(section3)
		
		let photosSource = PhotosSource()
		section1.addSource(photosSource)
		
		let folderSource = ImageFolderSource()
		self.folderSource = folderSource
		section3.addSource(folderSource)
		
//		self.restoreState()
		self.load()
	}
	
	/// Lets the user choose a folder and add a Container to the FolderSource
	
    func addFolder()
    {
		NSOpenPanel.presentModal(canChooseFiles:false, canChooseDirectories:true, allowsMultipleSelection:false)
		{
			guard let url = $0.first else { return }
			let folder = ImageFolderContainer(url:url)
			self.folderSource?.addContainer(folder)
		}
    }
}


//----------------------------------------------------------------------------------------------------------------------


