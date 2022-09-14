//
//  Detail.swift
//  MatchedView
//
//  Created by KISEKI on 2022/9/14.
//

import SwiftUI

struct Detail: View {
    
    var namespace:Namespace.ID
    var name:Name = names[0]
    @Binding var show:Bool
    @Binding var appear:Bool
    
    var body: some View {
        VStack{
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 1)){
                    show = false
                    appear = false
                }
            } label: {
                Image(systemName: "multiply")
                    .font(.largeTitle)
                    .padding()
            }
            .padding(100)
            Spacer()
            Text(name.itemName)
                .frame(maxWidth: .infinity,alignment: .trailing)
                .matchedGeometryEffect(id: "text\(name.id)", in: namespace)
                .padding(50)
        }
        .background{
            Image(name.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .matchedGeometryEffect(id: "color\(name.id)", in: namespace)
        }
        .ignoresSafeArea()
        
    }
    
}

