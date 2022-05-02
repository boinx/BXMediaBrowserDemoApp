//
//  ContentView.swift
//  com.boinx.BXMediaBrowser.demo.iOS
//
//  Created by Peter Baumgartner on 02.05.22.
//

import SwiftUI
import BXMediaBrowser

struct ContentView: View
{
    var body: some View
    {
		NavigationView
		{
			SidebarView()
			BrowserView()
		}
    }
}

struct SidebarView: View
{
    var body: some View
    {
        Text("Sidebar")
            .padding()
    }
}

struct BrowserView: View
{
    var body: some View
    {
        Text("Browser")
            .padding()
    }
}
