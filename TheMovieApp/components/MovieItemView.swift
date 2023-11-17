//
//  MovieItemView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct MovieItemView: View {
    var mMovie: MovieVO?
    var onTapFav: ((Int)->Void)?

    var body: some View {
        VStack(alignment: .leading){
            
            // Image
            MovieListItemImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseUrl() ?? "")
            
            // Text
            Text(mMovie?.title ?? "")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: TEXT_REGULAR_2X))
                .lineLimit(1)
                .padding(.top, MARGIN_MEDIUM)
            
            FavoriteButtonView(mMovie: mMovie, onTapFav: { value in
                guard let onTapFav = self.onTapFav else {
                    return
                }
                onTapFav(value)
                
            })
            
        }.frame(width: MOVIE_ITEM_WIDTH)
    }
}

struct MovieListItemImageView : View {
    var imageUrl : String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
                    .frame(width: MOVIE_ITEM_WIDTH,height: MOVIE_ITEM_HEIGHT)
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: MOVIE_ITEM_WIDTH,height: MOVIE_ITEM_HEIGHT)
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
                
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    MovieItemView()
}
