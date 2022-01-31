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
import SwiftUI


//----------------------------------------------------------------------------------------------------------------------


final class CustomViewFactory : ViewFactory
{
	override init()
	{
		super.init()
	}
	
	// Create a custom View and wrap it in a type-erased AnyView
	
	override public func containerView(for container:Container) -> AnyView
	{
		AnyView(Group
		{
//			if container is PhotosContainer
//			{
//				ContainerView(with:container).border(Color.red)
//			}
//			else
//			{
				ViewFactory.defaultContainerView(for:container)
//			}
		})
	}


	// Provide custom context menu
	
	override public func containerContextMenu(for container:Container) -> AnyView
	{
		AnyView(Group
		{
			if container is PhotosContainer
			{
				Button("Beep")
				{
					NSSound.beep()
				}

				Button("Bop")
				{
					NSSound.beep()
				}
			}
			else
			{
				ViewFactory.defaultContainerContextMenu(for:container)
			}
		})
	}


	/// Returns the type of ObjectCell subclass to be used for the specified Container
	
	override public func objectCellType(for container:Container?) -> ObjectCell.Type
	{
		super.objectCellType(for:container)
	}

}


//----------------------------------------------------------------------------------------------------------------------
