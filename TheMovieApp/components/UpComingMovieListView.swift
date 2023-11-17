//
//  UpComingMovieListView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct UpComingMovieListView: View {
    var mMovies : [MovieVO]?
    var label: String = ""
    var onTapFav: ((Int)->Void)?

    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(label)
                    .font(.system(size:TEXT_REGULAR_2X))
                    .fontWeight(.bold)
                    .padding(.top, MARGIN_MEDIUM_2)
                Spacer()
            }.padding([.leading,.trailing], MARGIN_CARD_MEDIUM_2)
        
            if mMovies?.isEmpty ?? true {
                EmptyView()
            } else {
                ForEach(mMovies ?? [MovieVO](), id: \.id, content: { movie in
                   NavigationLink(value: movie) {
                       UpComingMovieItemView(mMovie: movie){ value in
                           guard let onTapFav = self.onTapFav else {
                               return
                           }
                           onTapFav(value )
                       }
                       .padding(.horizontal, MARGIN_MEDIUM)

                    }
                    
                })
            }
        }
    }
}

#Preview {
    UpComingMovieListView()
}
