//
//  ListView.swift
//  MatchedView
//
//  Created by KISEKI on 2022/9/14.
//

import SwiftUI

struct ListView: View {
    @Namespace var namespace
    @State var show = false
    @State var selectID = UUID()
    @State var appear = false
    @State var screenSize:CGSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    @State var anchorPoint:UnitPoint = .init(x: 0, y: 0)
    
    @State var viewState:CGSize = CGSize.init(width: 0, height: 0)
    @State var isDrag = true
    
    var body: some View {
        ZStack{
            ScrollView{
                let gridItem = Array(repeating: GridItem(GridItem.Size.adaptive(minimum: 120, maximum: 200), spacing: 8, alignment: .leading), count: 2)
                LazyVGrid(columns: gridItem, spacing: 10) {
                    if !show {
                        card
                    }else{
                        ForEach(names){value in
                            if value.id == selectID{
                                Color.clear
                                    .frame(height: 150)
                            }else{
                                Item(namespace: namespace, name: value, text: value.itemName)
                            }
                        }
                    }
                }
                .padding(15)
            }
            .scaleEffect(show ? 5 : 1 , anchor: anchorPoint)
            .opacity(show ? 0 : 1)
            
            if show {
                ForEach (names){value in
                    if selectID == value.id{
                        Detail(namespace: namespace, name: value, show: $show, appear: $appear)
                            .scaleEffect(viewState.width / -600 + 1, anchor: anchorPoint)
                    }
                }
            }
        }
        .gesture(isDrag ? drag : nil)
    }
    
    var card:some View{
        ForEach(names){ value in
            Item(namespace: namespace, name: value, text: value.itemName)
                .overlay{
                    GeometryReader{proxy in
                        Button(action: {
                            isDrag = true
                            anchorPoint.y = proxy.frame(in: .global).midY/screenSize.height
                            anchorPoint.x = proxy.frame(in: .global).midX/screenSize.width
                            //计算出锚点位置
                            print(anchorPoint)
                            withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                                show.toggle()
                                selectID = value.id
                                appear.toggle()
                            }
                        }, label: {
                            Color.clear
                        })
                    }
                }
        }
    }
    
    var drag:some Gesture{
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onChanged { value in
                if value.translation.width > 0{
                    if value.startLocation.x < 30{
                        viewState = value.translation
                        if viewState.width > 150{
                            withAnimation(.spring(response: 0.4, dampingFraction: 1)){
                                show = false
                                appear = false
                                viewState = .zero
                            }
                            isDrag = false
                        }
                    }
                }
            }
            .onEnded { value in
                if viewState.width > 80{
                    isDrag = false
                    withAnimation(.spring(response: 0.45, dampingFraction: 1)){
                        show = false
                        appear = false
                        viewState = .zero
                    }
                }
                else{
                    withAnimation(.spring()){
                        viewState = .zero
                    }
                }
            }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
