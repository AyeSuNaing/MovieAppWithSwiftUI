//
//  GenreTabLayoutView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct GenreTabLayoutView: View {
    @State var genres : [GenreVO] = dummyGenres
    
    
    var body: some View {
        
        if genres.isEmpty {
            Text("Empty")
        }else {
            ScrollView(.horizontal, showsIndicators: false){
                ScrollViewReader{ scrollView in
                    HStack(spacing: MARGIN_MEDIUM_2){
                        ForEach(genres , id: \.name) { genre in
                            VStack{
                                Text(genre.name ?? "")
                                    .foregroundColor(genre.isSelected ?  Color(.black)  :.gray)
                                    .fontWeight(genre.isSelected ? .bold : .medium)
                                    .font(.system(size: TEXT_REGULAR))
                                
                                Rectangle()
                                    .fill(genre.isSelected ? Color(BLUE_COLOR) : .clear)
                                    .frame(height: 2)
                                
                            }
                            .onTapGesture {
                                genres = genres.map{ iteratedGenre in
                                    if genre.name == iteratedGenre.name {
                                        return GenreVO(name: iteratedGenre.name, isSelected: true)
                                    }
                                    else{
                                        return GenreVO(name: iteratedGenre.name, isSelected: false)
                                    }
                                }
                                withAnimation{
                                    scrollView.scrollTo(genre.name, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
        
      
    }
}

#Preview {
    GenreTabLayoutView()
}
