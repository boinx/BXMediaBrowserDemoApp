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
import Foundation

#if os(macOS)
import AppKit
#endif


//----------------------------------------------------------------------------------------------------------------------


class GenericLibrary : Library
{
	/// References to the various sections
	
	var librariesSection:Section? = nil
	var internetSection:Section? = nil
	var foldersSection:Section? = nil
	
	/// This reference to the FolderSource is needed by the addFolder() function
	
	var folderSource:FolderSource? = nil
	
	
//----------------------------------------------------------------------------------------------------------------------


	/// Creates the basic structure of the SampleLibrary
	
	override init(identifier:String)
	{
		super.init(identifier:identifier)
		
		let librariesSection = Section(identifier:"Libraries", name:Section.localizedNameLibraries)
		self.librariesSection = librariesSection
		self.addSection(librariesSection)
		
		let internetSection = Section(identifier:"Internet", name:Section.localizedNameInternet)
		self.internetSection = internetSection
		self.addSection(internetSection)
		
		let foldersSection = Section(identifier:"Folders", name:Section.localizedNameFolders)
		self.foldersSection = foldersSection
		self.addSection(foldersSection)
		
		// When the user clicks on the "+" button in the Folder section, then add a new Container for a user selected folder
		
		foldersSection.addSourceHandler =
		{
			[weak self] _ in
			guard let self = self else { return }
			self.addFolder(to:self.folderSource)
		}
	}
	

//----------------------------------------------------------------------------------------------------------------------


	/// Lets the user choose a folder and add a Container to the FolderSource
	
    func addFolder(to folderSource:FolderSource?)
    {
		guard let folderSource = folderSource else { return }
		
		#if os(macOS)
		
		NSOpenPanel.presentModal(canChooseFiles:false, canChooseDirectories:true, allowsMultipleSelection:false)
		{
			guard let url = $0.first else { return }
			let container = self.createContainer(for:url)
			folderSource.addContainer(container)
		}
		
		#else
		
		#warning("TODO: implement for iOS")
		
		#endif
    }
    
    /// This function should be overridden in subclasses to create a specialized subclass of FolderContainer
	
    func createContainer(for url:URL) -> FolderContainer
    {
		let filter = self.folderSource?.filter as? FolderFilter ?? FolderFilter()
		
		return FolderContainer(url:url, filter:filter)
		{
			[weak self] in self?.removeTopLevelFolder($0)
		}
    }
    
    func removeTopLevelFolder(_ container:Container)
    {
		let title = NSLocalizedString("Alert.title.removeFolder", bundle:.BXMediaBrowser, comment:"Alert Title")
		let message = String(format:NSLocalizedString("Alert.message.removeFolder", bundle:.BXMediaBrowser, comment:"Alert Message"), container.name)
		let ok = NSLocalizedString("Remove", bundle:.BXMediaBrowser, comment:"Button Title")
		let cancel = NSLocalizedString("Cancel", bundle:.BXMediaBrowser, comment:"Button Title")
		
		#if os(macOS)
		
		NSAlert.presentModal(style:.critical, title:title, message:message, okButton:ok, cancelButton:cancel)
		{
			[weak self] in self?.folderSource?.removeContainer(container)
		}
		
		#else
		
		#warning("TODO: implement for iOS")
		
		#endif
    }


//----------------------------------------------------------------------------------------------------------------------


	override func saveState(_ state:[String:Any])
	{
		self.state = state
	}

	public var state:[String:Any]?
	{
		set { UserDefaults.standard.set(newValue, forKey:stateKey) }
		get { UserDefaults.standard.dictionary(forKey:stateKey) }
	}
}


//----------------------------------------------------------------------------------------------------------------------
