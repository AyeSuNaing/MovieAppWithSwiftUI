//
//  FavoriteButtonView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI
struct FavoriteButtonView: View{
    var mMovie: MovieVO?
    @State var isFavorite: Bool = false
    var onTapFav: ( (Int) -> Void)?
    
    let movieModel = MovieModelImpl.shared
   
    init(isFavorite: Bool = false , mMovie: MovieVO? = nil, onTapFav: ( (Int) -> Void)? = nil) {
        self.mMovie = mMovie
        self.onTapFav = onTapFav
        
        _isFavorite = State(initialValue: mMovie?.isFavorite ?? false)
        
    }
    
    var body: some View{
        HStack{
            Image(systemName: isFavorite ? IC_HEARTFILL : IC_HEART)
                .resizable()
                .foregroundColor(.red)
                .frame(width: MARGIN_MEDIUM_2,
                       height: MARGIN_MEDIUM_2)
                .onTapGesture {
                    
                    guard let onTapFav = self.onTapFav else {
                        return
                    }
                    isFavorite = !isFavorite // Modify @State variable
                   

                    onTapFav(mMovie?.id ?? 0)
                    
                }
           
        }
    }
}
