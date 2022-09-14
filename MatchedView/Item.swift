//
//  Item.swift
//  MatchedView
//
//  Created by KISEKI on 2022/9/14.
//

import SwiftUI

struct Item: View {
    var namespace:Namespace.ID
    var name:Name = names[1]
    var text:String
    
    var body: some View {
        VStack{
            Text(text)
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
                .matchedGeometryEffect(id: "text\(name.id)", in: namespace)
            
        }
        .foregroundColor(.red)
        .background(
            Image(name.background)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .matchedGeometryEffect(id: "color\(name.id)", in: namespace)
                
        )
        .frame(height: 300)
        
    }
}

struct Item_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        Item(namespace: namespace,text: "liuminliang".uppercased())
    }
}

