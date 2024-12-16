import SwiftUI

struct box {
    let id:Int
}
struct test6: View {
    @Namespace private var animationNamespace
//    @Namespace private var animationNamespace2
    @State var boxs :[box] = [1,2,3,4,5,6].map{ box(id:$0) }
    @State var selected :box?

    var body: some View {
        VStack {
            if let select = selected {
                Text("\(select.id)")
                    .font(.title)
                    .frame(width: 100, height: 100)
                    .background{
                        Rectangle()
                            .foregroundStyle(.blue)
                    }
                    .matchedGeometryEffect(id: select.id, in: animationNamespace)
            }
                        Spacer()
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack{
                    ForEach(boxs,id: \.id){i in
                        CardView(i: i, namespace: animationNamespace, boxs: $boxs,selected: $selected)

                    }
                }
            }
        }
        .padding()
    }
}

struct CardView:View{
    var i : box
    var namespace:Namespace.ID
    @Binding var boxs :[box]
    @Binding var selected:box?
    var body: some View{
        Text("\(i.id)")
            .font(.title)
            .frame(width: 80, height: 80)
            .background{
                Rectangle()
                    .foregroundStyle(.blue)
            }
            .onTapGesture {
                withAnimation(.linear(duration:0.3)){
//                                    print("\(i)")
                    if selected != nil {
                        boxs = boxs.map{ $0.id == i.id ? selected! : $0 }
                    }
                    boxs.removeAll{ $0.id == i.id}
                    if selected != nil {
                        boxs.sort{ $0.id < $1.id }
                    }
                    selected = i

                }
            }
            .matchedGeometryEffect(id: i.id, in: namespace)
    }
}



#Preview{
    test6(selected: nil)
}
