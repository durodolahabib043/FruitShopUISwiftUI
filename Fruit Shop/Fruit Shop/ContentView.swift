//
//  ContentView.swift
//  Fruit Shop
//
//  Created by Javid Shaikh on 04/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            
            VStack {
                /// Part 01
                Header()
                OfferProductCard()
                
                /// Part 02
                CategoryTextHeader()
                ProductList()
                
                Spacer()
                BottomTabBar()
            }
            .padding()
           
        }
        
    }
    
    @ViewBuilder
    private func Header() -> some View {
        HStack {
            
            Button(action: {}, label: {
                Image(systemName: "menucard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "cart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            })
            
            Button(action: {}, label: {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            })
            
        }
    }
    
    @ViewBuilder
    private func OfferProductCard() -> some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(height: 220)
            .overlay {
                ZStack {
                    Image("basket")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(CGSize(width: 100.0, height: 50.0))
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("O F F E R")
                                .foregroundStyle(.yellow)
                            
                            Text("Flat 35% Off")
                                .foregroundStyle(.white)
                                .font(.title)
                            
                            Text("In honor to world health day we'd like to  give you this amazing offer")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .frame(width: 150)
                                
                            
                            Button(action: {}, label: {
                                
                                RoundedRectangle(cornerRadius: 5.0)
                                    .overlay {
                                        Text("View Offers")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 10))
                                            .bold()
                                    }
                                    .foregroundStyle(.yellow)
                                
                            })
                            .frame(width: 80, height: 30)
                            
                        }
                        Spacer()
                        
                    }
                    .padding()
                }
            }
            .clipped()
            .shadow(radius: 10)
            .padding(.top, 20)
        
    }
    
    @ViewBuilder
    private func CategoryTextHeader() -> some View {
        HStack {
            Text("Fruits")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
            
            Spacer()
            
            Text("View All")
                .font(.callout)
                .foregroundStyle(.yellow)
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func ProductList() -> some View {
        HStack {
            ForEach(fruits, id: \.id) { fruit in
                ProductCard(fruit: fruit)
            }
        }
    }
    
    @ViewBuilder
    private func ProductCard(fruit: Fruit) -> some View {
        Button(action: {}, label: {
            
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 300)
                .overlay {
                    VStack {
                        Rectangle()
                            .foregroundStyle(.white.opacity(0.4))
                            .frame(height: 150)
                            .overlay {
                                Image(fruit.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120)
                            }
                            .offset(CGSize(width: 0.0, height: -10.0))
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 7) {
                                Text("F R U I T")
                                    .foregroundStyle(.yellow)
                                    .font(.caption)
                                
                                Text(fruit.name)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28))
                                    .bold()
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(.yellow)
                                        .frame(width: 12, height: 12)
                                    
                                    Text("(\(fruit.reviews) Reviews)")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 12))
                                        .bold()
                                }
                                
                                HStack {
                                    Text("$\(fruit.price)")
                                        .foregroundStyle(.yellow)
                                        .font(.title2)
                                        .bold()
                                    
                                    Text("per kg")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 12))
                                        .bold()
                                }
                            }.padding()
                            Spacer()
                            
                        }
                    }
                }
                .clipShape(
                    .rect(
                        topLeadingRadius: 100,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 100
                    )
                )
            
            
        })
        .foregroundStyle(.black)
    }
    
    @State var selectedTab = 1
    @ViewBuilder
    private func BottomTabBar() -> some View {
        ZStack {
            HStack {
                ForEach(TabItems.allCases, id: \.self) { item in
                    Button {
                        selectedTab = item.rawValue
                    } label: {
                        TabItemView(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func TabItemView(imageName: String, title: String, isActive: Bool) -> some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(isActive ? .black : .white)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(.black)
            }
        }
        .frame(width: isActive ? 150 : 60, height: 60)
        .background(isActive ? .white : .clear)
        .cornerRadius(30)
    }
    
}

#Preview {
    ContentView()
}

struct Fruit: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var price: String
    var reviews: String
}

var fruits = [
    Fruit(name: "Apple", imageName: "apple", price: "6.25", reviews: "121"),
    Fruit(name: "Mango", imageName: "mango", price: "3.25", reviews: "100"),
]


enum TabItems: Int, CaseIterable{
    case search = 0
    case home
    case cart
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .cart:
            return "Cart"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .cart:
            return "cart"
        }
    }
}
