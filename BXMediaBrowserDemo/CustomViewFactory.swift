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
	
	public func build(with model:Any) -> AnyView
	{
		let view = Self.customView(for:model)
		return AnyView(view)
	}


	/// This function creates custom views as needed for the host application
	
	@ViewBuilder static public func customView(for model:Any) -> some View
	{
		// Create a custom view for some model types (as required by the UI design of the host app)
		
		if let container = model as? Container
		{
			ContainerView(with:container)
		}
		
		// Use default views (provided) by the BXMediaBrowser package for all other model types
		
		else
		{
			DefaultViewFactory.defaultView(for:model)
		}
	}
}


//----------------------------------------------------------------------------------------------------------------------
