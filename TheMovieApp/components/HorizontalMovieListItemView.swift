//
//  HorizontalMovieListItemView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct HorizontalMovieListItemView: View {
    var mMovieList : [MovieVO]?
    var onTapFav: ((Int)->Void)?


    var body: some View {
        
        
        if mMovieList?.isEmpty ?? true {
            EmptyView()
        } else {
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    ForEach(mMovieList ?? [MovieVO](), id: \.id, content: { movie in
                       NavigationLink(value: movie) {
                           MovieItemView(mMovie: movie){ value in
                               guard let onTapFav = self.onTapFav else {
                                   return
                               }
                               onTapFav(value )
                           }

                        }
                        
                    })
                }.padding()
            }
        }
    }
}


#Preview {
    HorizontalMovieListItemView()
}
