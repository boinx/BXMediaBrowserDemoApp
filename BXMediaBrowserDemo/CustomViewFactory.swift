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


public struct CustomViewFactory : ViewFactory
{
	// Create the View and wrap it in a type-erased AnyView
	
	public func containerView(for model:Any) -> AnyView
	{
		// If desired, create a custom view for some model classes here
		
		if false
		{
		
		}
		
		// For all other model classes you can simply use the default views
		
		let view = DefaultViewFactory.defaultContainerView(for:model)
		return AnyView(view)
	}


	/// Returns a header view that is appropriate for the currently selected Container of the Library
	
	public func objectsHeaderView(for library:Library) -> AnyView
	{
		let view = DefaultViewFactory.defaultObjectsHeaderView(for:library)
		return AnyView(view)
	}
	

	/// Returns a footer view that is appropriate for the currently selected Container
	
	public func objectsFooterView(for library:Library) -> AnyView
	{
		let view = DefaultViewFactory.defaultObjectsFooterView(for:library)
		return AnyView(view)
	}
	
	
	/// Returns the type of ObjectCell subclass to be used for the specified Container
	
	public func objectCellType(for container:Container?) -> ObjectCell.Type
	{
		DefaultViewFactory.defaultObjectCellType(for:container)
	}
}


//----------------------------------------------------------------------------------------------------------------------
