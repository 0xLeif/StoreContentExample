//
//  ContentView.swift
//  StoreContentExample
//
//  Created by Leif on 9/27/22.
//

import CacheStore
import SwiftUI

extension StoreActionHandler
where Key == ContentView.Key,
      Action == ContentView.Action,
      Dependency == ContentView.Dependency
{
    static let handler: StoreActionHandler = StoreActionHandler { cacheStore, action, _ in
        switch action {
        case let .updateName(name):
            cacheStore.set(value: name, forKey: .name)
        }
        
        return .none
    }
}

struct ContentView: StoreView {
    enum Key: Hashable {
        case name
    }
    
    enum Action {
        case updateName(String)
    }
    
    struct Content: StoreContent {
        var name: String
        
        init(store: Store<Key, Void, Void>) {
            name = store.resolve(.name)
        }
    }
    
    @ObservedObject var store: Store<Key, Action, Void>
    
    init(store: Store<Key, Action, Void>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, \(content.name)!")
            
            TextField("Name", text: store.binding(.name, using: Action.updateName))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialValues: [.name: "Anonymous"],
                actionHandler: .handler,
                dependency: ()
            )
        )
    }
}
