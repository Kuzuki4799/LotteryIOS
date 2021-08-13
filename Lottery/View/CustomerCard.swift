//
//  CustomerCard.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI

struct CustomerCard: View {
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
                if !homeData.startAnimation{
                    Image("shoe").resizable().aspectRatio(contentMode: .fit).padding(.horizontal)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                }
                
                VStack(alignment: .trailing, spacing: 10, content: {
                    Text("Air Max Exosense 'Atomic Powder'")
                        .fontWeight(.semibold).foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    
                    Text("$270.00").fontWeight(.bold).foregroundColor(.black)
                })
            }.padding()
            
            Divider()
            
            Text("Select Size").font(.caption).fontWeight(.semibold)
                .foregroundColor(.gray).padding(.top)
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15, content: {
                ForEach(sizes, id: \.self){ size in
                    Button(action: {
                        withAnimation{
                            homeData.selectedSize = size
                        }
                    }, label: {
                        Text(size).fontWeight(.semibold)
                            .foregroundColor(homeData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(homeData.selectedSize == size ? Color.red : Color.black.opacity(0.06)).cornerRadius(10)
                    })
                }
            }).padding(.top)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)){
                    homeData.startAnimation.toggle()
                }
            }, label: {
                Text("Add to Card").fontWeight(.bold).foregroundColor(homeData.selectedSize == "" ? .black : .white).padding(.vertical).frame(maxWidth: .infinity)
                    .background(homeData.selectedSize == "" ? Color.black.opacity(0.06): Color.red)
                    .cornerRadius(18)
            }).disabled(homeData.selectedSize == "")
            .padding(.vertical)
        }.padding()
        .background(Color.white.clipShape(CustomConor(corner: [.topLeft, .topRight], radius: 35)))
    }
}

struct CustomerCard_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCard()
    }
}
